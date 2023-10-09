import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:aljouf/constants/urls.dart';
import 'package:aljouf/home/models/category.dart';
import 'package:aljouf/home/models/location.dart';
import 'package:aljouf/product/models/product.dart';

class HomeService {
  static Future<List<dynamic>?> getBanners({
    required String id,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=feed/rest_api/banners&id=$id&language=ar'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data;
    } else {
      return null;
    }
  }

  static Future<List<Category>?> getCategories() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=feed/rest_api/categories&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Category>?> getSubCategories({required String id}) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=feed/rest_api/categories&id=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data']['sub_categories'];
      print('data: $data');
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Product>?> getCategoryProducts({
    required String id,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=feed/rest_api/products&category=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Product>?> getWishlistProducts() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=rest/wishlist/wishlist&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      return null;
    }
  }

  static Future<bool> addToWishlist({
    required String id,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print('token: $token');
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/wishlist/wishlist&id=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('$baseUrl route=rest/wishlist/wishlist&id=$id&language=$lang');
    print('response status code: ${response.statusCode}');
    print(jsonDecode(response.body));
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteFromWishlist({
    required String id,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.delete(
      Uri.parse('$baseUrl route=rest/wishlist/wishlist&id=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> contactUs({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String enquiry,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print('token: $token');
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/contact/send&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
      body: jsonEncode({
        "name": "$firstName $lastName",
        "phone": "+966$phone",
        "email": email,
        "enquiry": enquiry,
      }),
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getStaticPage(
      {required String id}) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=feed/rest_api/information&id=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.first;
    } else {
      return null;
    }
  }

  static Future<List<Location>?> getLocations() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=feed/rest_api/locations&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((location) => Location.fromJson(location)).toList();
    } else {
      return null;
    }
  }

  // ------------------------------------------<Coupon>------------------------------

  static Future<String?> createCoupon({
    required String customerId,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final response = await http.post(
      Uri.parse('${baseUrl}route=rest/couponfirstdownload/createnew'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
      body: jsonEncode({
        'customer_id': customerId,
      }),
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      String coupon = jsonDecode(response.body)['data'][0]['code'].toString();
      return coupon;
    } else {
      return null;
    }
  }

  static Future<String?> getCoupon() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? customerId = getStorage.read('customerId');
    print(customerId);
    final response = await http.get(
      Uri.parse(
          '${baseUrl}route=rest/couponfirstdownload/get_first_download_coupon&customer_id=$customerId'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    print(
        '${baseUrl}route=rest/couponfirstdownload/get_first_download_coupon&customer_id=$customerId');
    if (jsonDecode(response.body)['success'] == 1) {
      String coupon = jsonDecode(response.body)['data'][0]['code'].toString();
      print('coupon: $coupon');
      await addCouponToCart(coupon: coupon, customerId: customerId!);
      return coupon;
    } else {
      return null;
    }
  }

  static Future<void> addCouponToCart({
    required String coupon,
    required String customerId,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final response = await http.post(
      Uri.parse('${baseUrl}route=rest/couponfirstdownload/couponaddtocart'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
      body: jsonEncode({
        'coupon': coupon,
        'customer_id': customerId,
      }),
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      print('success');
    } else {
      print('error');
    }
  }
}
