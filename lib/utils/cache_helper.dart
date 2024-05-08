import 'dart:convert';
import 'dart:developer';

import 'package:aljouf/product/models/product.dart';
import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static final _box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  static dynamic read(String key) {
    return _box.read(key);
  }

  static Future<void> remove(String key) async {
    await _box.remove(key);
  }

  static Future<void> clear() async {
    await _box.erase();
  }

  //   ====   This For Checkout   ====
  static const String _cartListName = 'ListCart';

  static Future<bool> addToCart({
    required Product product,
    required String quantity,
  }) async {
    product.quantity = quantity;

    bool isSaved = false;
    List<Product> productsList = [];
    List<Product> productsListTemp = [];

    getMyListCart().forEach((prod) {
      productsListTemp.add(prod);
      productsList.add(prod);
    });

    if (productsListTemp.isEmpty) {
      productsList.add(product);

      log("Start <=> Write");
      await clearCartList();
      await write(_cartListName, jsonEncode(productsList));
    } else {
      log(" else ");
      Product? prodTemp;
      var existingProduct = productsListTemp.firstWhere(
        (prod) => prod.id.toString() == product.id.toString(),
        orElse: () => Product(id: "-9999"),
      );

      prodTemp = existingProduct;

      existingProduct.quantity = quantity;

      if (prodTemp.id == "-9999") {
        productsList.add(product);
        log("Start <=> Write");

        await clearCartList();
        await write(_cartListName, jsonEncode(productsList));
      }
    }

    productsList.clear();
    productsListTemp.clear();
    getMyListCart().forEach((prod) {
      productsList.add(prod);
    });

    log("My List Cart After Add : ${productsList.length.toString()}");
    for (var prod in productsList) {
      String prodID = prod.id.toString();
      String productID = product.id.toString();
      if (prodID == productID) {
        isSaved = true;
        log("isSaved break");
        break;
      } else {
        isSaved = false;
      }
    }
    log("isSaved $isSaved");
    return isSaved;
  }

  static Future<bool> upDateCart({
    required Product product,
    required String quantity,
  }) async {
    product.quantity = quantity;

    bool isSaved = false;
    List<Product> productsList = [];
    List<Product> productsListTemp = [];

    getMyListCart().forEach((prod) {
      productsListTemp.add(prod);
      productsList.add(prod);
    });
    log("productsList: ${productsListTemp.length.toString()}");

    for (int i = 0; i < productsList.length; i++) {
      if (productsList[i].id.toString() == product.id.toString()) {
        productsList[i].quantity = quantity;
        log("UPDATE <=> quantity  :: ${productsList[i].quantity}");
      }
    }
    log("Start <=> Write");
    await clearCartList();
    await write(_cartListName, jsonEncode(productsList));

    productsList.clear();
    productsListTemp.clear();
    getMyListCart().forEach((prod) {
      productsList.add(prod);
    });

    log("My List Cart After Add : ${productsList.length.toString()}");
    for (var prod in productsList) {
      String prodID = prod.id.toString();
      String productID = product.id.toString();
      if (prodID == productID) {
        isSaved = true;
        log("isSaved break");
        break;
      } else {
        isSaved = false;
      }
    }
    log("isSaved $isSaved");
    return isSaved;
  }

  static Future<bool> deleteFromCart({
    required Product product,
  }) async {
    List<Product> productsList = [];
    List<Product> productsListTemp = [];
    try {
      getMyListCart().forEach((prod) {
        productsListTemp.add(prod);
        productsList.add(prod);

        log("Prod ID: ${prod.id.toString()}");
      });
      log("productsList: ${productsListTemp.length.toString()}");

      productsList
          .removeWhere((prod) => prod.id.toString() == product.id.toString());

      await clearCartList();
      await write(_cartListName, jsonEncode(productsList));

      productsList.clear();
      productsListTemp.clear();
      getMyListCart().forEach((prod) {
        productsList.add(prod);
      });

      log("My List Cart After Delete : ${productsList.length.toString()}");
      return true;
    } catch (e) {
      return false;
    }
  }

  static List<Product> getMyListCart() {
    List<Product> productsList = [];
    List temp = [];

    productsList.clear();
    temp.clear();
    if (read(_cartListName) != null) {
      if (read(_cartListName) is String) {
        temp = jsonDecode(read(_cartListName));
      } else {
        temp = read(_cartListName);
      }

      for (var prod in temp) {
        productsList.add(Product.fromJson(prod));
      }
    }

    log("My List Cart  getMyListCart ():${productsList.length.toString()}");
    return productsList;
  }

  static Future<void> clearCartList() async {
    await remove(_cartListName);
  }
}
