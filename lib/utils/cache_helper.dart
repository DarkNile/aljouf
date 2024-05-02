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

  // this for checkout

//   static Future<bool> addToCart({
//     required String id,
//     required String quantity,
//   }) async {
//     bool isSaved = false;
//     List<ProductCacheModel> myListCart = read('ListCart') ?? [];
//     log("My List Cart : ${myListCart.toString()}");

//     for (var product in myListCart) {
//       if (product.id != id) {
//         myListCart.add(ProductCacheModel(
//           id: id,
//           quantity: quantity,
//         ));
//       }
//     }
//     await write('ListCart', jsonEncode(myListCart));
//     List<ProductCacheModel> getMyListCart = read('ListCart') ?? [];
//     log("My List Cart After Add : ${getMyListCart.toString()}");
//     for (var prod in getMyListCart) {
//       if (prod.id == id) {
//         isSaved = true;
//         log("isSaved $isSaved");
//         break;
//       } else {
//         isSaved = false;
//         log("isSaved $isSaved");
//         break;
//       }
//     }

//     return isSaved;
//   }
// }

  static Future<bool> addToCart({
    required Product product,
    required String quantity,
  }) async {
    // if (true) {
    //   clear();
    //   return true;
    // }
    product.quantity = quantity;

    bool isSaved = false;
    List<Product> productsList = [];
    List<Product> productsListTemp = [];

    log(" product ID    ____+++____ ${product.id}");
    log(" product productID    ____+++____ ${product.productId}");
    productsList.clear();
    productsListTemp.clear();
    getMyListCart().forEach((prod) {
      productsListTemp.add(prod);
      productsList.add(prod);

      log("Prod ID: ${prod.id.toString()}");
    });
    log("productsList: ${productsListTemp.length.toString()}");

    if (productsListTemp.isEmpty) {
      productsList.add(product);

      log("Start <=> Write");
      await remove('ListCart');
      await write('ListCart', jsonEncode(productsList));
    } else {
      // Product? prodTemp;
      // for (var prod in productsListTemp) {
      //   String prodID = prod.id.toString();
      //   String productID = product.id.toString();
      //   if (prodID == productID) {
      //     prodTemp = null;
      //     break;
      //   }

      //   prodTemp = prod;
      // }
      // if (prodTemp != null) {
      //   log("if (prodTemp != null) {}");
      //   productsList.add(prodTemp);
      //   log("Start <=> Write");
      //   await remove('ListCart');
      //   await write('ListCart', jsonEncode(productsList));
      // }
      Product? prodTemp;
      var existingProduct = productsListTemp.firstWhere(
        (prod) => prod.id.toString() == product.id.toString(),
        orElse: () => Product(id: "-9999"),
      );
      existingProduct.quantity = quantity;
      prodTemp = existingProduct;

      if (prodTemp.id == "-9999") {
        productsList.add(product);
        log("Start <=> Write");
        await remove('ListCart');
        await write('ListCart', jsonEncode(productsList));
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
        log("isSaved $isSaved");
        break;
      } else {
        isSaved = false;
        log("isSaved $isSaved");
      }
    }
    return isSaved;
  }

  static Future<bool> upDateCart({
    required Product product,
    required String quantity,
  }) async {
    // if (true) {
    //   clear();
    //   return true;
    // }
    product.quantity = quantity;

    bool isSaved = false;
    List<Product> productsList = [];
    List<Product> productsListTemp = [];

    log(" product ID    ____+++____ ${product.id}");
    log(" product productID    ____+++____ ${product.productId}");
    productsList.clear();
    productsListTemp.clear();
    getMyListCart().forEach((prod) {
      productsListTemp.add(prod);
      productsList.add(prod);

      log("Prod ID: ${prod.id.toString()}");
    });
    log("productsList: ${productsListTemp.length.toString()}");

    for (int i = 0; i < productsList.length; i++) {
      if (productsList[i].id.toString() == product.id.toString()) {
        productsList[i].quantity = quantity;
        log("UPDATE <=> quantity  :: ${productsList[i].quantity}");
      }
    }
    log("Start <=> Write");
    await remove('ListCart');
    await write('ListCart', jsonEncode(productsList));

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
        log("isSaved $isSaved");
        break;
      } else {
        isSaved = false;
        log("isSaved $isSaved");
      }
    }
    return isSaved;
  }

  static Future<bool> deleteFromCart({
    required Product product,
  }) async {
    List<Product> productsList = [];
    List<Product> productsListTemp = [];
    try {
      log(" product ID    ____+++____ ${product.id}");
      log(" product productID    ____+++____ ${product.productId}");
      productsList.clear();
      productsListTemp.clear();
      getMyListCart().forEach((prod) {
        productsListTemp.add(prod);
        productsList.add(prod);

        log("Prod ID: ${prod.id.toString()}");
      });
      log("productsList: ${productsListTemp.length.toString()}");

      productsList
          .removeWhere((prod) => prod.id.toString() == product.id.toString());

      await remove('ListCart');
      await write('ListCart', jsonEncode(productsList));

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
    if (read('ListCart') != null) {
      if (read('ListCart') is String) {
        temp = jsonDecode(read('ListCart'));
      } else {
        temp = read('ListCart');
      }

      for (var prod in temp) {
        productsList.add(Product.fromJson(prod));
      }
    }

    log("My List Cart  getMyListCart ():${productsList.length.toString()}");
    return productsList;
  }
}

class ProductCacheModel {
  final List<Product> myListCart;

  ProductCacheModel({
    required this.myListCart,
  });

  Map<String, dynamic> toJson() => {
        'ListCart': jsonEncode(myListCart),
      };

  factory ProductCacheModel.fromJson(Map<String, dynamic> json) =>
      ProductCacheModel(
        myListCart: jsonDecode(json['ListCart']),
      );
}
