import 'dart:convert';
import 'dart:developer';

import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:aljouf/auth/models/user.dart';
import 'package:aljouf/constants/urls.dart';
import 'package:aljouf/screens/splash/splash_screen.dart';
import 'package:aljouf/utils/app_util.dart';

class AuthService {
  static Future<User?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirm,
    required String telephone,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
        Uri.parse('$baseUrl route=rest/register/register&language=$lang'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          // "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
        },
        body: json.encode({
          'firstname': firstName.trim(),
          'lastname': lastName.trim(),
          'email': email.trim(),
          'password': password.trim(),
          'confirm': confirm.trim(),
          'telephone': telephone.trim(),
        }));

    print("response.statusCode");
    print(response.statusCode);

    if (jsonDecode(response.body)['success'] == 1) {
      Map<String, dynamic> user = jsonDecode(response.body)['data'];
      print(user);
      String token = user['session_id'];
      print(token);
      var customerId = user['customer_id'];
      print(customerId);
      final getStorage = GetStorage();
      await getStorage.write('token', token);
      await getStorage.write('customerId', customerId.toString());
      bool isSendAll = await sendCachedProductsToCart();
      if (isSendAll) {
        return User.fromJson(user);
      } else {
        if (context.mounted) {
          AppUtil.errorToast(
              context, "Something went wrong please try again".tr);
        }
        return null;
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

  static Future<User?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
        Uri.parse('$baseUrl route=rest/login/login&language=$lang'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          // "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
        },
        body: json.encode({
          'email': email.trim(),
          'password': password.trim(),
        }));

    print("response.statusCode");
    print(response.statusCode);

    if (jsonDecode(response.body)['success'] == 1) {
      Map<String, dynamic> user = jsonDecode(response.body)['data'];
      print(user);
      String token = user['session_id'];
      print(token);
      var customerId = user['customer_id'];
      print(customerId);
      final getStorage = GetStorage();
      await getStorage.write('token', token);
      await getStorage.write('customerId', customerId.toString());
      bool isSendAll = await sendCachedProductsToCart();
      if (isSendAll) {
        return User.fromJson(user);
      } else {
        if (context.mounted) {
          AppUtil.errorToast(
              context, "Something went wrong please try again".tr);
        }
        return null;
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

  static Future<void> logout(BuildContext context) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/logout/logout&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print("response.statusCode");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      getStorage.remove('token');
      getStorage.remove('customerId');
      Get.deleteAll(force: true);
      Phoenix.rebirth(Get.context!);
      Get.reset();
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
    }
  }

  static Future<bool> forgetPass(
      {required String email, required BuildContext context}) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print('token $token');
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
        Uri.parse('$baseUrl route=rest/forgotten/forgotten&language=$lang'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          // "Cookie": "OCSESSID=$token; currency=SAR;",
        },
        body: json.encode({
          'email': email.trim(),
        }));

    if (jsonDecode(response.body)['success'] == 1) {
      print(jsonDecode(response.body));
      return true;
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<bool> verifyPhone({
    required String customerId,
    required String phone,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print('token $token');
    final response = await http.post(Uri.parse('$baseUrl route=rest/phoneotp'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          "Cookie": "OCSESSID=$token; currency=SAR;",
        },
        body: json.encode({
          'cutomer_id': customerId,
          'telephone': phone.trim(),
        }));

    if (jsonDecode(response.body)['success'] == 1) {
      print(jsonDecode(response.body));
      return true;
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<bool> verifyOTP({
    required String customerId,
    required String phone,
    required String otp,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final response =
        await http.post(Uri.parse('$baseUrl route=rest/phoneotp/check_otp'),
            headers: {
              'Accept': 'application/json',
              // 'Authorization': 'Bearer $token',
              "Cookie": "OCSESSID=$token; currency=SAR;",
            },
            body: jsonEncode({
              'cutomer_id': customerId,
              'telephone': phone.trim(),
              'otp': otp,
            }));

    if (jsonDecode(response.body)['success'] == 1) {
      print(jsonDecode(response.body));
      return true;
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<bool> checkOTP({
    required String email,
    required String activationCode,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
        Uri.parse('$baseUrl route=rest/forgotten/check_otp&language=$lang'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          // "Cookie": "OCSESSID=$token; currency=SAR;",
        },
        body: jsonEncode({
          'email': email.trim(),
          'activation_code': activationCode,
        }));

    if (jsonDecode(response.body)['success'] == 1) {
      print(jsonDecode(response.body));
      return true;
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<bool> changePassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.put(
        Uri.parse('$baseUrl route=rest/account/password&language=$lang'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          // "Cookie": "OCSESSID=$token; currency=SAR;",
        },
        body: jsonEncode({
          'email': email.trim(),
          'password': password.trim(),
          'confirm': passwordConfirmation.trim(),
        }));

    print(jsonEncode({
      'email': email.trim(),
      'password': password.trim(),
      'confirm': passwordConfirmation.trim(),
    }));
    print(jsonDecode(response.body));

    if (jsonDecode(response.body)['success'] == 1) {
      return true;
    } else {
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return false;
    }
  }

  static Future<User?> loginUsingSocialMedia({
    required String email,
    required String accessToken,
    required String provider,
    required BuildContext context,
  }) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/login/socialLogin&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        // "Cookie":
        //     "OCSESSID=${token != null && token.isNotEmpty ? token : '8d87b6a83c38ea74f58b36afc3'}; currency=SAR;",
      },
      body: json.encode({
        "email": email.trim(),
        "access_token": accessToken,
        "provider": provider,
      }),
    );
    print('${jsonDecode(response.body)}');
    if (jsonDecode(response.body)['success'] == 1) {
      Map<String, dynamic> user = jsonDecode(response.body)['data'];
      print(user);
      String token = user['session_id'];
      print(token);
      var customerId = user['customer_id'];
      print(customerId);
      final getStorage = GetStorage();
      getStorage.write('token', token);
      getStorage.write('customerId', customerId.toString());
      return User.fromJson(user);
    } else {
      print(response.body);
      var errorMessage = jsonDecode(response.body)['error'];
      if (context.mounted) {
        AppUtil.errorToast(context, errorMessage[0]);
      }
      return null;
    }
  }

  static Future<void> deleteAccount() async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.delete(
      Uri.parse('$baseUrl route=rest/account/deleteUser&language=$lang'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=$token; currency=SAR;",
      },
    );
    print("response.statusCode");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final getStorage = GetStorage();
      getStorage.remove('token');
      getStorage.remove('customerId');
      Get.offAll(() => const SplashScreen());
    }
  }

  // ======  This For Send Cached Products Data To Cart  ======

  static Future<bool> sendCachedProductsToCart() async {
    final CheckoutController controller = Get.put(CheckoutController());
    List<Product> products = CacheHelper.getMyListCart();

    try {
      if (products.isNotEmpty) {
        await Future.wait(
          products.map(
            (prod) async => await controller.addToCart(
              productId: prod.id.toString(),
              quantity: prod.quantity.toString(),
            ),
          ),
        );
        await CacheHelper.clearCartList();
        log("Success Add To Cart");
        return true;
      } else {
        log("Empty ListCart");
        return true;
      }
    } catch (e) {
      log("Error adding item to cart: $e");
      return false;
    }
  }
}
