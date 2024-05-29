import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/home/services/apps_flyer_service.dart';
import 'package:get/get.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/product/services/product_service.dart';

class ProductController extends GetxController {
  var isProductsLoading = false.obs;
  var products = <Product>[].obs;
  var isFilteredProductsLoading = false.obs;
  var filteredProducts = <Product>[].obs;
  var page = 1.obs;

  Future<List<Product>?> getProductsByCategoryId({
    required String categoryId,
    required HomeController homeController,
  }) async {
    try {
      isProductsLoading(true);
      final data =
          await ProductService.getProductsByCategoryId(categoryId: categoryId);
      if (data != null) {
        products(data);
        homeController.manageFavProducts(products);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isProductsLoading(false);
    }
  }

  List<String> productIds = [];

  Future<List<Product>?> getFilteredProducts({
    required String categoryId,
    required String categoryName,
    String search = '',
    String order = '',
    String sort = '',
    required HomeController homeController,
  }) async {
    productIds.clear();
    try {
      isFilteredProductsLoading(true);
      print(page.value.toString());
      final data = await ProductService.getFilteredProducts(
        categoryId: categoryId,
        search: search,
        page: page.value.toString(),
        order: order,
        sort: sort,
      );
      if (data != null) {
        filteredProducts.addAll(data);
        homeController.manageFavProducts(filteredProducts);
        for (var product in filteredProducts) {
          productIds.add(product.id.toString());
        }
        AppsFlyerService.appsflyerSdk.logEvent(
          'af_list_view',
          {
            'af_content_type': categoryName,
            'af_content_list': productIds,
          },
        );
        return filteredProducts;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isFilteredProductsLoading(false);
    }
  }

  Future<List<Product>?> filterByPrice({
    required String categoryId,
    required String minPrice,
    required String maxPrice,
    required HomeController homeController,
  }) async {
    Map<String, dynamic> formData = {};
    if (categoryId.isEmpty) {
      formData = {
        "filters": [
          {
            "field": "price",
            "operand": ">=",
            "value": minPrice,
          },
          {
            "field": "price",
            "operand": "<=",
            "value": maxPrice,
          },
        ],
      };
    } else {
      formData = {
        "filters": [
          {
            "field": "category",
            "operand": "=",
            "value": categoryId,
          },
          {
            "field": "price",
            "operand": ">=",
            "value": minPrice,
          },
          {
            "field": "price",
            "operand": "<=",
            "value": maxPrice,
          },
        ],
      };
    }
    print(formData);
    try {
      filteredProducts.clear();
      isFilteredProductsLoading(true);
      print(page.value.toString());
      final data = await ProductService.filterByPrice(
        formData: formData,
        page: page.value.toString(),
      );
      if (data != null) {
        filteredProducts(data);
        homeController.manageFavProducts(filteredProducts);
        return filteredProducts;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isFilteredProductsLoading(false);
    }
  }
}
