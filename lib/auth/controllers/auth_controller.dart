import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/models/user.dart';
import 'package:aljouf/auth/services/auth_service.dart';

class AuthController extends GetxController {
  var isRegisterLoading = false.obs;
  var isLoginLoading = false.obs;
  var isForgetPasswordLoading = false.obs;
  var isOTPLoading = false.obs;
  var isProfileLoading = false.obs;
  var isChangePasswordLoading = false.obs;
  var isSocialLoginLoading = false.obs;
  var isVerifyPhoneLoading = false.obs;
  var isVerifyOtpLoading = false.obs;
  var user = User().obs;

  Future<User?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirm,
    required String telephone,
    required BuildContext context,
  }) async {
    try {
      isRegisterLoading(true);
      final user = await AuthService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirm: confirm,
        telephone: '+966$telephone',
        context: context,
      );
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isRegisterLoading(false);
    }
  }

  Future<User?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoginLoading(true);
      final user = await AuthService.login(
        email: email,
        password: password,
        context: context,
      );
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isLoginLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await AuthService.logout(context);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> forgetPass({
    required String email,
    required BuildContext context,
  }) async {
    try {
      isForgetPasswordLoading(true);
      final isSuccess = await AuthService.forgetPass(
        email: email,
        context: context,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isForgetPasswordLoading(false);
    }
  }

  Future<bool> verifyPhone({
    required String customerId,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      isVerifyPhoneLoading(true);
      final isSuccess = await AuthService.verifyPhone(
        customerId: customerId,
        phone: phone,
        context: context,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isVerifyPhoneLoading(false);
    }
  }

  Future<bool> verifyOTP({
    required String customerId,
    required String phone,
    required String otp,
    required BuildContext context,
  }) async {
    try {
      isVerifyOtpLoading(true);
      final isSuccess = await AuthService.verifyOTP(
        customerId: customerId,
        phone: phone,
        otp: otp,
        context: context,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isVerifyOtpLoading(false);
    }
  }

  Future<bool> checkOTP({
    required String email,
    required String activationCode,
    required BuildContext context,
  }) async {
    try {
      isOTPLoading(true);
      final isSuccess = await AuthService.checkOTP(
        email: email,
        activationCode: activationCode,
        context: context,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isOTPLoading(false);
    }
  }

  Future<bool> changePassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required BuildContext context,
  }) async {
    try {
      isChangePasswordLoading(true);
      final isSuccess = await AuthService.changePassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        context: context,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isChangePasswordLoading(false);
    }
  }

  Future<User?> loginUsingSocialMedia({
    required BuildContext context,
    required String email,
    required String accessToken,
    required String provider,
  }) async {
    try {
      isSocialLoginLoading(true);
      final user = await AuthService.loginUsingSocialMedia(
        email: email,
        accessToken: accessToken,
        provider: provider,
        context: context,
      );
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isSocialLoginLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await AuthService.deleteAccount();
    } catch (e) {
      print(e);
    }
  }
}
