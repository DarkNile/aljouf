import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/models/user.dart';
import 'package:aljouf/profile/models/address.dart';
import 'package:aljouf/profile/models/city.dart';
import 'package:aljouf/profile/models/country.dart';
import 'package:aljouf/profile/models/tracking_order.dart';
import 'package:aljouf/profile/models/wallet.dart';
import 'package:aljouf/profile/models/zone.dart';
import 'package:aljouf/profile/services/profile_service.dart';

class ProfileController extends GetxController {
  var isProfileLoading = false.obs;
  var isCountriesLoading = false.obs;
  var isZonesLoading = false.obs;
  var isCitiesLoading = false.obs;
  var isAddingAddress = false.obs;
  var isEditingAddress = false.obs;
  var isAddressLoading = false.obs;
  var isWalletLoading = false.obs;
  var isUserOrdersLoading = false.obs;
  var isUserOrdersByStatusLoading = false.obs;
  var user = User().obs;
  var countries = <Country>[].obs;
  var zones = <Zone>[].obs;
  var cities = <City>[].obs;
  var addresses = <Address>[].obs;
  var wallet = Wallet().obs;
  var userOrders = <TrackingOrder>[].obs;
  var userOrdersByStatus = <TrackingOrder>[].obs;

  Future<User?> getAccount() async {
    try {
      isProfileLoading(true);
      final data = await ProfileService.getAccount();
      if (data != null) {
        user(data);
        return user.value;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isProfileLoading(false);
    }
  }

  Future<bool> editAccount({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String telephone,
  }) async {
    try {
      isProfileLoading(true);
      final isSuccess = await ProfileService.editAccount(
        context: context,
        firstName: firstName,
        lastName: lastName,
        email: email,
        telephone: telephone,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isProfileLoading(false);
    }
  }

  Future<List<Country>?> getCountries() async {
    try {
      isCountriesLoading(true);
      final data = await ProfileService.getCountries();
      if (data != null) {
        countries(data);
        return countries;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCountriesLoading(false);
    }
  }

  Future<List<Zone>?> getZones() async {
    try {
      isZonesLoading(true);
      final data = await ProfileService.getZones();
      if (data != null) {
        zones(data);
        return zones;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isZonesLoading(false);
    }
  }

  Future<List<City>?> getCitiesByZoneId({required String zoneId}) async {
    try {
      isCitiesLoading(true);
      final data = await ProfileService.getCitiesByZoneId(zoneId: zoneId);
      if (data != null) {
        cities(data);
        return cities;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCitiesLoading(false);
    }
  }

  Future<List<Address>?> getAddress({required BuildContext context}) async {
    try {
      isAddressLoading(true);
      final data = await ProfileService.getAddress(context: context);
      if (data != null) {
        addresses(data);
        return addresses;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isAddressLoading(false);
    }
  }

  Future<bool> addAddress({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String city,
    required String address,
    required int countryId,
    required int zoneId,
  }) async {
    try {
      isAddingAddress(true);
      final isSuccess = await ProfileService.addAddress(
        context: context,
        firstName: firstName,
        lastName: lastName,
        city: city,
        countryId: countryId,
        zoneId: zoneId,
        address: address,
      );
      if (context.mounted) {
        getAddress(context: context);
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isAddingAddress(false);
    }
  }

  Future<bool> editAddress({
    required String id,
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String city,
    required String address,
    required int countryId,
    required int zoneId,
  }) async {
    try {
      isEditingAddress(true);
      final isSuccess = await ProfileService.editAddress(
        id: id,
        context: context,
        firstName: firstName,
        lastName: lastName,
        city: city,
        countryId: countryId,
        zoneId: zoneId,
        address: address,
      );
      if (context.mounted) {
        getAddress(context: context);
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isEditingAddress(false);
    }
  }

  Future<bool> deleteAddress({
    required String id,
    required BuildContext context,
  }) async {
    try {
      final isSuccess = await ProfileService.deleteAddress(
        id: id,
        context: context,
      );
      if (isSuccess) {
        if (context.mounted) {
          getAddress(context: context);
        }
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Wallet?> getWalletBalance({required BuildContext context}) async {
    try {
      isWalletLoading(true);
      final data = await ProfileService.getWalletBalance(context: context);
      if (data != null) {
        wallet(data);
        return wallet.value;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isWalletLoading(false);
    }
  }

  Future<List<TrackingOrder>?> getUserOrders() async {
    try {
      isUserOrdersLoading(true);
      final data = await ProfileService.getUserOrders();
      if (data != null) {
        userOrders(data);
        return userOrders;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isUserOrdersLoading(false);
    }
  }

  Future<List<TrackingOrder>?> getUserOrdersByStatus({
    required String orderStatus,
  }) async {
    try {
      isUserOrdersByStatusLoading(true);
      final data = await ProfileService.getUserOrdersByStatus(
        orderStatus: orderStatus,
      );
      if (data != null) {
        userOrdersByStatus(data);
        return userOrdersByStatus;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isUserOrdersByStatusLoading(false);
    }
  }
}
