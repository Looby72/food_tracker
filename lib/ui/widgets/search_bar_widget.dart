import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../data/internal_product.dart';
import '../../data/product_query.dart';
import '../../data/routes.dart';
import 'barcode_scanner_widget.dart';
import 'product_image_widget.dart';

// debounceDuration is the time to wait after the last input before making the API call
const Duration debounceDuration = Duration(milliseconds: 300);

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  late final _Debounceable<Iterable<Product>?, String> _debouncedSearch;

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<Product>?, String>(queryByName);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SearchAnchor(
  //       viewHintText: 'Produktsuche',
  //       isFullScreen: true,
  //       builder: (BuildContext context, SearchController controller) {
  //         return _buildSearchBar(context, controller);
  //       },
  //       viewBuilder: (Iterable<Widget> suggestions) {
  //         return _buildView(suggestions);
  //       },
  //       suggestionsBuilder:
  //           (BuildContext context, SearchController controller) {
  //         if (controller.text.isNotEmpty) {
  //           return _getSuggestions(controller);
  //         } else {
  //           // we could return a list of recent searches here
  //           return const <Widget>[];
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 56.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(32.0),
          /*onTap: () {
          Navigator.pushNamed(context, Routes.search);
        },*/
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.search,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Produktsuche',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 16.0)),
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      const BarcodeScannerWidget(),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.createProduct);
                        },
                        icon: Icon(Icons.add_box_outlined,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

  /// Fetches products from the OpenFoodFacts API by name.
  /// Returns a list of Widgets that represent the products.
  Future<Iterable<Widget>> _getSuggestions(SearchController controller) async {
    final suggestions =
        (await _debouncedSearch(controller.text))?.toList() ?? <Product>[];

    return suggestions.map((Product product) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          title: Text(product.productName ?? 'Unbekanntes Produkt',
              overflow: TextOverflow.ellipsis),
          subtitle: Text(
            product.brands ?? '',
            overflow: TextOverflow.ellipsis,
          ),
          leading: ProductImg(
              imageUrl: product.imageFrontUrl, width: 50, height: 50),
          onTap: () {
            final InternalProduct internalProduct =
                InternalProduct.fromProduct(product: product);
            Navigator.pushNamed(
              context,
              Routes.productDetail,
              arguments: internalProduct,
            );
          },
        ),
      );
    });
  }

  /// Builds the search bar with the search icon, barcode scanner and add product button.
  Widget _buildSearchBar(BuildContext context, SearchController controller) {
    return SearchBar(
      controller: controller,
      hintText: '   Produktsuche',
      leading: Transform.translate(
        offset: const Offset(10, 0),
        child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
      ),
      trailing: <Widget>[
        Transform.translate(
          offset: const Offset(10, 0),
          child: const BarcodeScannerWidget(),
        ),
        Transform.translate(
          offset: const Offset(5, 0),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.createProduct),
            icon: Icon(Icons.add_box_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
      onTap: () {
        controller.openView();
      },
    );
  }

  /// Builds the view of the suggestions.
  Widget _buildView(Iterable<Widget> suggestions) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 0),
        itemCount: suggestions.length,
        itemBuilder: (context, index) => suggestions.elementAt(index),
        separatorBuilder: (context, index) => const SizedBox(height: 4.0),
      ),
    );
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
