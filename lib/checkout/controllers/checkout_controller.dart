import 'dart:developer';

import 'package:aljouf/checkout/services/rating_service.dart';
import 'package:aljouf/home/services/apps_flyer_service.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/models/cart.dart';
import 'package:aljouf/checkout/models/order.dart';
import 'package:aljouf/checkout/models/payment_method.dart';
import 'package:aljouf/checkout/services/checkout_service.dart';

import '../models/shipping_method.dart';

class CheckoutController extends GetxController {
  var isCartLoading = false.obs;
  Cart? cart;
  Order? order;
  var isAddingShippingAddress = false.obs;
  var isAddingPaymentAddress = false.obs;
  var isShippingMethodsLoading = false.obs;
  var shippingMethods = <ShippingMethod>[].obs;
  var isPaymentMethodsLoading = false.obs;
  var paymentMethods = <PaymentMethod>[].obs;
  var isCouponLoading = false.obs;
  var isConfirmOrderLoading = false.obs;
  var isSavingOrderLoading = false.obs;
  var isAddingShippingMethodLoading = false.obs;
  var isAddingPaymentMethodLoading = false.obs;
  var isRatingLoading = false.obs;
  var total = 0.0.obs;
  var cartItems = 0.obs;
  var isCouponAdded = false.obs;
  var couponController = TextEditingController().obs;
  var isShippingRateLoading = false.obs;
  var shippingRate = 0.obs;
  var shippingCode = ''.obs;
  var isOutOfStock = false.obs;

  Future<int?> getShippingRate() async {
    try {
      isShippingRateLoading(true);
      final data = await CheckoutService.getShippingRate();
      shippingRate(data);
      return shippingRate.value;
    } catch (e) {
      print(e);
      return null;
    } finally {
      isShippingRateLoading(false);
    }
  }

  Future<bool?> showRatingApp() async {
    try {
      isRatingLoading(true);
      final isSuccess = await RatingService().showRating();
      if (isSuccess) {
        return isSuccess;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      isRatingLoading(false);
    }
  }

  Future<Cart?> getCartItems() async {
    log("Future<Cart?> getCartItems()");
    try {
      isCartLoading(true);

      final data = await CheckoutService.getCartItems();
      if (data != null) {
        cart = data;
        cartItems(cart!.totalProductCount);
        log(" cartItems Start ${cartItems.value}");
        total(0.0);
        for (var element in cart!.products!) {
          total(total.value += element.totalRaw);
          log("++++++++=========+++++++++==");
          log("priceRaw ${element.priceRaw}");
          log("price ${element.price}");
          log("priceExcludingTax ${element.priceExcludingTax}");
          log("originPrice ${element.originPrice}");
          log("priceExcludingTaxFormated ${element.priceExcludingTaxFormated}");
          log("priceFormated ${element.priceFormated}");
          log("++++++++=========+++++++++==");
        }

        log("API CART ${cart!.products!.length}");

        CacheHelper.getMyListCart().forEach((prod) {
          if (cart?.products != null || cart!.products!.isNotEmpty) {
            for (int i = 0; i < cart!.products!.length; i++) {
              //    =======  IF PRODUCT IS ALREADY IN CART     =======
              if (cart!.products![i].id.toString() == prod.id.toString()) {
                cart!.products![i].qty = prod.qty.toString();
                cartItems(cartItems.value += 1);
              }
            }

            // for (int i = 0; i < cart!.products!.length; i++) {
            //   if (cart!.products![i].id.toString() == prod.id.toString()) {
            //     cart!.products![i].qty = prod.qty.toString();
            //     cartItems(cartItems.value += 1);
            //   } else {
            //     cartItems(cartItems.value += 1);
            //     cart!.products!.add(prod);
            //   }
            // }

            // cart!.products!.add(prod);
            // cartItems(cartItems.value += 1);

            String price = prod.priceRaw ?? "0.0";

            log("Prod price ${prod.priceRaw}");
            total(total.value += double.parse(price));
          }
        });
        log("  cartItems Last ${cartItems.value}");

        return cart;
      } else {
        log("Cart == null");
        print("else");
        List<Product>? products = [];
        cartItems(0);
        total(0);

        CacheHelper.getMyListCart().forEach((prod) {
          products.add(prod);

          String price = prod.priceRaw ?? "0.0";

          log("Prod price ${prod.priceRaw}");

          total(total.value += double.parse(price));
        });

        cartItems(products.length);
        log("cartItems $cartItems");
        cart = Cart(
          total: total.value.toStringAsFixed(2),
          totalProductCount: cartItems.value,
          totalRaw: total.value,
          products: products,
        );
        return cart;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCartLoading(false);
    }
  }

  Future<bool> addToCart({
    required String productId,
    required String quantity,
  }) async {
    try {
      final isSuccess = await CheckoutService.addToCart(
        productId: productId,
        quantity: quantity,
      );
      if (isSuccess) {
        getCartItems();
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateCartItemQuantity({
    required String productId,
    required String quantity,
  }) async {
    try {
      cartItems(0);
      total(0.0);
      for (var element in cart!.products!) {
        cartItems(cartItems.value += int.parse(element.quantity));
        total(total.value += element.priceRaw * int.parse(element.quantity));
      }
      await CheckoutService.updateCartItemQuantity(
        productId: productId,
        quantity: quantity,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCartItem({
    required String productId,
  }) async {
    try {
      await CheckoutService.deleteCartItem(
        productId: productId,
      );
      cartItems(0);
      total(0.0);
      for (var element in cart!.products!) {
        cartItems(cartItems.value += int.parse(element.quantity));
        total(total.value += element.priceRaw * int.parse(element.quantity));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearCart() async {
    try {
      await CheckoutService.clearCart();
      cartItems(0);
      total(0.0);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addShippingAddress({
    required BuildContext context,
    required int addressId,
  }) async {
    try {
      isAddingShippingAddress(true);
      final isSuccess = await CheckoutService.addShippingAddress(
        context: context,
        addressId: addressId,
      );
      if (isSuccess) {
        if (context.mounted) {
          addPaymentAddress(
            context: context,
            addressId: addressId,
          );
        }
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isAddingShippingAddress(false);
    }
  }

  Future<bool> addPaymentAddress({
    required BuildContext context,
    required int addressId,
  }) async {
    try {
      isAddingPaymentAddress(true);
      final isSuccess = await CheckoutService.addPaymentAddress(
        context: context,
        addressId: addressId,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isAddingPaymentAddress(false);
    }
  }

  Future<List<ShippingMethod>?> getShippingMethods(
      {required BuildContext context}) async {
    try {
      isShippingMethodsLoading(true);
      final data = await CheckoutService.getShippingMethods(context: context);
      if (data != null) {
        shippingMethods(data);
        return shippingMethods;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isShippingMethodsLoading(false);
    }
  }

  Future<bool> addShippingMethod({
    required BuildContext context,
    required String shippingMethodCode,
  }) async {
    try {
      isAddingShippingMethodLoading(true);
      final isSuccess = await CheckoutService.addShippingMethod(
        context: context,
        shippingMethodCode: shippingMethodCode,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isAddingShippingMethodLoading(false);
    }
  }

  Future<List<PaymentMethod>?> getPaymentMethods(
      {required BuildContext context}) async {
    try {
      isPaymentMethodsLoading(true);
      final data = await CheckoutService.getPaymentMethods(context: context);
      if (data != null) {
        paymentMethods(data);
        return paymentMethods;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isPaymentMethodsLoading(false);
    }
  }

  Future<bool> addPaymentMethod({
    required BuildContext context,
    required String paymentMethodCode,
  }) async {
    try {
      isAddingPaymentMethodLoading(true);
      final isSuccess = await CheckoutService.addPaymentMethod(
        context: context,
        paymentMethodCode: paymentMethodCode,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isAddingPaymentMethodLoading(false);
    }
  }

  Future<bool> addCoupon({
    required BuildContext context,
    required String coupon,
  }) async {
    try {
      isCouponLoading(true);
      final isSuccess = await CheckoutService.addCoupon(
        context: context,
        coupon: coupon,
      );
      if (isSuccess) {
        isCouponAdded(true);
        couponController.value.text = coupon;
        if (context.mounted) {
          confirmOrder(context: context);
        }
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isCouponLoading(false);
    }
  }

  Future<bool> deleteCoupon({
    required BuildContext context,
  }) async {
    try {
      isCouponLoading(true);
      final isSuccess = await CheckoutService.deleteCoupon(
        context: context,
      );
      if (isSuccess) {
        isCouponAdded(false);
        couponController.value.clear();
        if (context.mounted) {
          confirmOrder(context: context);
        }
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isCouponLoading(false);
    }
  }

  Future<Order?> confirmOrder({
    required BuildContext context,
  }) async {
    try {
      isConfirmOrderLoading(true);
      final data = await CheckoutService.confirmOrder(
        context: context,
      );
      if (data != null) {
        order = data;
        return order;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isConfirmOrderLoading(false);
    }
  }

  Future<bool> saveOrderToDatabase({
    required Order order,
  }) async {
    try {
      isSavingOrderLoading(true);
      final isSuccess = await CheckoutService.saveOrderToDatabase();
      if (isSuccess) {
        AppsFlyerService.logPurchase(
          orderId: order.orderId.toString(),
          price: double.parse(order.total.toString()),
          currency: 'SAR',
          quantity: order.products!.length,
        );
        clearCart();
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isSavingOrderLoading(false);
    }
  }
}
