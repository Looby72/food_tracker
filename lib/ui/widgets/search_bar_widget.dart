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

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
        barHintText: 'Produktsuche',
        isFullScreen: true,
        barLeading:
            Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
        barTrailing: <Widget>[
          Transform.translate(
            offset: const Offset(15, 0),
            child: const BarcodeScannerWidget(),
          ),
          Transform.translate(
            offset: const Offset(10, 0),
            child: IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.createProduct),
              icon: Icon(Icons.add_box_outlined,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
        suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
          if (controller.text.isNotEmpty) {
            final suggestions = await _getSuggestions(controller);
            if (suggestions.isEmpty) {
              return <Widget>[
                const ListTile(
                  title: Text('Keine Ergebnisse gefunden'),
                  leading: Icon(Icons.search_off),
                )
              ];
            } else {
              return suggestions;
            }
          } else {
            return const <Widget>[];
          }
        });
  }

  /// Fetches products from the OpenFoodFacts API by name.
  /// Returns a list of Widgets that represent the products.
  Future<Iterable<Widget>> _getSuggestions(SearchController controller) async {
    final suggestions =
        (await _debouncedSearch(controller.text))?.toList() ?? <Product>[];

    return suggestions.map((Product product) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(5.0),
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
