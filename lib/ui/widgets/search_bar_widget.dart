import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../data/routes.dart';

const Duration debounceDuration = Duration(milliseconds: 500);

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  //string of current query if null there is no pending query
  String? _currentQuery;
  //most recent API Suggestions
  late Iterable<Widget> _lastOptions = <Widget>[];
  late final _Debounceable<Iterable<Product>?, String> _debouncedSearch;

  Future<Iterable<Product>?> _search(String query) async {
    _currentQuery = query;

    //make API call
    SearchResult response;
    try {
      response = await OpenFoodAPIClient.searchProducts(
        null,
        ProductSearchQueryConfiguration(
          parametersList: <Parameter>[
            SearchTerms(terms: [_currentQuery!]),
            const PageNumber(page: 1),
            const PageSize(size: 20),
          ],
          fields: <ProductField>[
            ProductField.BARCODE,
            ProductField.NUTRIMENTS,
            ProductField.NAME,
            ProductField.BRANDS,
            ProductField.IMAGE_FRONT_URL,
            ProductField.SERVING_SIZE
          ],
          version: ProductQueryVersion.v3,
          language: OpenFoodFactsLanguage.GERMAN,
        ),
      );
    } catch (error) {
      // Handle the timeout error here
      return const <Product>[];
    }
    //no products are retrieved
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
    return SearchAnchor.bar(
        barHintText: 'Produktsuche',
        isFullScreen: false,
        suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
          final List<Product> options =
              (await _debouncedSearch(controller.text))?.toList() ??
                  <Product>[];
          if (options.isEmpty) {
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
                Navigator.pushNamed(
                  context,
                  Routes.productDetail,
                  arguments: product,
                );
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
