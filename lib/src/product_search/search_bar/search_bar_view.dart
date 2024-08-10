import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

const Duration debounceDuration = Duration(milliseconds: 500);

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  /* final TextEditingController _searchController = TextEditingController();
  Future<SearchResult>? _futureResult;

  void _searchProducts(String query) {
    setState(() {
      _futureResult = OpenFoodAPIClient.searchProducts(
        null,
        ProductSearchQueryConfiguration(
          parametersList: <Parameter>[
            SearchTerms(terms: [query])
          ],
          version: ProductQueryVersion.v3,
        ),
      );
    });
  }

  //builder function for displaying the product data
  Widget _buildProductInfo(
      BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
    if (snapshot.hasData) {
      final products = snapshot.data!.products;
      if (products == null || products.isEmpty) {
        return const Text('No results found');
      }
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.productName ?? 'No name'),
            subtitle: Text(product.brands ?? 'No brand'),
            leading: product.imageFrontUrl != null
                ? Image.network(product.imageFrontUrl!)
                : null,
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _searchProducts(_searchController.text);
              },
            ),
          ),
        ),
        Expanded(
          child: (_futureResult == null)
              ? const Text('Nothing to see yet')
              : FutureBuilder<SearchResult>(
                  future: _futureResult,
                  builder: (context, snapshot) {
                    return _buildProductInfo(context, snapshot);
                  },
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  } */

  //string of current query if null there is no pending query
  String? _currentQuery;
  //most recent API Suggestions
  late Iterable<Widget> _lastOptions = <Widget>[];
  late final _Debounceable<Iterable<Product>?, String> _debouncedSearch;

  Future<Iterable<Product>?> _search(String query) async {
    _currentQuery = query;

    //make API call
    SearchResult response = await OpenFoodAPIClient.searchProducts(
      null,
      ProductSearchQueryConfiguration(
        parametersList: <Parameter>[
          SearchTerms(terms: [_currentQuery!])
        ],
        version: ProductQueryVersion.v3,
      ),
    );
    //error Handling
    if (response.products == null) {
      return const <Product>[];
    }

    List<Product> options = response.products!;
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<Product>?, String>(_search);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(suggestionsBuilder:
        (BuildContext context, SearchController controller) async {
      _currentQuery = controller.text;
      //make API call
      SearchResult response = await OpenFoodAPIClient.searchProducts(
        null,
        ProductSearchQueryConfiguration(
          parametersList: <Parameter>[
            SearchTerms(terms: [_currentQuery!])
          ],
          version: ProductQueryVersion.v3,
        ),
      );

      if (response.products == null) {
        return const <Widget>[];
      }
      List<Product> options = response.products!;
      if (_currentQuery != controller.text) {
        return _lastOptions;
      }

      _lastOptions = options.map((Product product) {
        return ListTile(
          title: Text(product.productName ?? 'No name'),
          subtitle: Text(product.brands ?? 'No brand'),
          leading: product.imageFrontUrl != null
              ? Image.network(product.imageFrontUrl!)
              : null,
          onTap: () {
            debugPrint('Selected product: ${product.productName}');
          },
        );
      });

      return _lastOptions;
    });
  }
}

// define some helper classes copied from https://api.flutter.dev/flutter/material/SearchAnchor-class.html
typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}
