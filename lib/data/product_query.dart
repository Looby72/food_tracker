import 'package:openfoodfacts/openfoodfacts.dart';

/// OpenFoodFacts User which is used to query products
User? _user;
ProductQueryVersion _version = ProductQueryVersion.v3;
List<ProductField>? _fields = <ProductField>[
  ProductField.BARCODE,
  ProductField.NUTRIMENTS,
  ProductField.NAME,
  ProductField.BRANDS,
  ProductField.IMAGE_FRONT_URL,
  ProductField.SERVING_SIZE
];
OpenFoodFactsLanguage? _language = OpenFoodFactsLanguage.GERMAN;
OpenFoodFactsCountry? _country = OpenFoodFactsCountry.GERMANY;

/// query a product from OpenFoodFacts API by product name
Future<Iterable<Product>> queryByName(String name) async {
  //make API call
  SearchResult response;
  try {
    response = await OpenFoodAPIClient.searchProducts(
      _user,
      ProductSearchQueryConfiguration(
          parametersList: [
            SearchTerms(terms: [name]),
            const PageNumber(page: 1),
            const PageSize(size: 20),
          ],
          fields: _fields,
          version: _version,
          language: _language,
          country: _country),
    );
  } catch (error) {
    // timeout error
    return const <Product>[];
  }
  //no products are retrieved retun an empty list
  if (response.products == null) {
    return const <Product>[];
  }

  return response.products!;
}

/// query a product from OpenFoodFacts API by barcode
Future<Product?> queryByBarcode(String barcode) async {
  ProductResultV3 response;
  try {
    response = await OpenFoodAPIClient.getProductV3(ProductQueryConfiguration(
        barcode,
        version: _version,
        language: _language,
        country: _country,
        fields: _fields));
  } catch (error) {
    // timeout error
    return null;
  }

  return response.product;
}
