import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:aljouf/constants/urls.dart';
import 'package:aljouf/product/models/product.dart';

class ProductService {
  static Future<List<Product>?> getProductsByCategoryId({
    required String categoryId,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=feed/rest_api/products&category=$categoryId&language=$lang'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
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

  static Future<List<Product>?> getFilteredProducts({
    required String categoryId,
    required String search,
    required String page,
    required String order,
    required String sort,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=feed/rest_api/products&search=$search&page=$page&limit=20&language=$lang&category=$categoryId&order=$order&sort=$sort&filter_description=1'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
    );
    print(
        '$baseUrl route=feed/rest_api/products&search=$search&page=$page&limit=20&language=$lang&category=$categoryId&order=$order&sort=$sort&filter_description=1');
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Product>?> filterByPrice({
    required Map<String, dynamic> formData,
    required String page,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse(
          '$baseUrl route=feed/rest_api/search&page=$page&limit=20&language=$lang'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },
      body: json.encode(formData),
    );
    print(
        '$baseUrl route=feed/rest_api/search&page=$page&limit=20&language=$lang');
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      print(jsonDecode(response.body)['data']);
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      return null;
    }
  }
}
