import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:aljouf/auth/models/user.dart';
import 'package:aljouf/constants/urls.dart';
import 'package:aljouf/profile/models/address.dart';
import 'package:aljouf/profile/models/city.dart';
import 'package:aljouf/profile/models/country.dart';
import 'package:aljouf/profile/models/tracking_order.dart';
import 'package:aljouf/profile/models/wallet.dart';
import 'package:aljouf/profile/models/zone.dart';
import 'package:aljouf/utils/app_util.dart';

class ProfileService {
  static Future<User?> getAccount() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=rest/account/account&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );

    print("response.statusCode");
    print(response.statusCode);
    print('$baseUrl route=rest/account/account');
    print('${jsonDecode(response.body)}');

    if (jsonDecode(response.body)['success'] == 1) {
      Map<String, dynamic> user = jsonDecode(response.body)['data'];
      print('user: $user');
      return User.fromJson(user);
    } else {
      return null;
    }
  }

  static Future<bool> editAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String telephone,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.put(
      Uri.parse('$baseUrl route=rest/account/account&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
      body: jsonEncode({
        "firstname": firstName.trim(),
        "lastname": lastName.trim(),
        "email": email.trim(),
        "telephone": telephone.trim(),
      }),
    );

    print("response.statusCode");
    print(response.statusCode);

    if (jsonDecode(response.body)['success'] == 1) {
      print(jsonDecode(response.body)['data']);
      return true;
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<List<Country>?> getCountries() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=feed/rest_api/countries&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data.map((country) => Country.fromJson(country)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Zone>?> getZones() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=feed/rest_api/countries&id=184&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data']['zone'];
      print('data: $data');
      return data.map((zone) => Zone.fromJson(zone)).toList();
    } else {
      return null;
    }
  }

  static Future<List<City>?> getCitiesByZoneId({
    required String zoneId,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=feed/rest_api/cities&id=$zoneId&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data']['cities'];
      print('data: $data');
      return data.map((city) => City.fromJson(city)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Address>?> getAddress({
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=rest/account/address&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      if (data is List) {
        return null;
      }
      List<dynamic> addresses = data['addresses'];
      print('data: $addresses');
      return addresses.map((address) => Address.fromJson(address)).toList();
    } else {
      print(response.body);
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return null;
    }
  }

  static Future<bool> addAddress({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String city,
    required String address,
    required int countryId,
    required int zoneId,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final String? customerId = getStorage.read('customerId');
    print(customerId);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/account/address&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
      body: jsonEncode({
        "customer_id": customerId,
        "firstname": firstName,
        "lastname": lastName,
        "city": city,
        "address_1": address,
        "country_id": countryId,
        "zone_id": zoneId,
      }),
    );
    print(jsonEncode({
      "customer_id": customerId,
      "firstname": firstName,
      "lastname": lastName,
      "city": city,
      "address_1": address,
      "country_id": countryId,
      "zone_id": zoneId,
    }));
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      print(response.body);
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<bool> editAddress({
    required String id,
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String city,
    required String address,
    required int countryId,
    required int zoneId,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.put(
      Uri.parse('$baseUrl route=rest/account/address&id=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
      body: jsonEncode({
        "firstname": firstName,
        "lastname": lastName,
        "city": city,
        "address_1": address,
        "country_id": countryId,
        "zone_id": zoneId,
      }),
    );
    print(jsonEncode({
      "firstname": firstName,
      "lastname": lastName,
      "city": city,
      "address_1": address,
      "country_id": countryId,
      "zone_id": zoneId,
    }));
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      print(response.body);
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<bool> deleteAddress({
    required String id,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.delete(
      Uri.parse('$baseUrl route=rest/account/address&id=$id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      print(response.body);
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<Wallet?> getWalletBalance({
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=rest/account/transactions&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      var data = jsonDecode(response.body)['data'];
      print('data: $data');
      if (data is List) {
        return null;
      } else {
        return Wallet.fromJson(data);
      }
    } else {
      print(response.body);
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return null;
    }
  }

  static Future<List<TrackingOrder>?> getUserOrders() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse('$baseUrl route=rest/order/orders&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data
          .map((trackingOrder) => TrackingOrder.fromJson(trackingOrder))
          .toList();
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      print(errorMessage);
      return null;
    }
  }

  static Future<List<TrackingOrder>?> getUserOrdersByStatus({
    required String orderStatus,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.get(
      Uri.parse(
          '$baseUrl route=rest/order/orders&order_status=$orderStatus&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return data
          .map((trackingOrder) => TrackingOrder.fromJson(trackingOrder))
          .toList();
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      print(errorMessage);
      return null;
    }
  }
}
