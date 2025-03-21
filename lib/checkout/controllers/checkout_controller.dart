import 'dart:developer';

import 'package:aljouf/checkout/services/rating_service.dart';
import 'package:aljouf/home/services/apps_flyer_service.dart';
import 'package:aljouf/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/models/cart.dart';
import 'package:aljouf/checkout/models/order.dart';
import 'package:aljouf/checkout/models/payment_method.dart';
import 'package:aljouf/checkout/services/checkout_service.dart';
import 'package:gtm/gtm.dart';

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
  final gtm = Gtm.instance;

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
          // log("++++++++=========+++++++++==");
          // log("priceRaw ${element.priceRaw}");
          // log("price ${element.price}");
          // log("priceExcludingTax ${element.priceExcludingTax}");
          // log("originPrice ${element.originPrice}");
          // log("priceExcludingTaxFormated ${element.priceExcludingTaxFormated}");
          // log("priceFormated ${element.priceFormated}");
          // log("++++++++=========+++++++++==");
        }

        log("API CART ${cart!.products!.length}");
        log("  Cart Items Last ${cartItems.value}");
        log(" ---------- \n ");
        data.products?.forEach((pro) {
          log("  Cart Products ( Id  )  ${pro.id}");
          log("  Cart Products ( name  )  ${pro.name}");
          log("  Cart Products ( quantity  )  ${pro.quantity}");
          log("  Cart Products ( qty  )  ${pro.qty}");
          log("  ---------- \n ");
        });
        return cart;
      } else {
        //      ===>>> IF Read From Cache ===>>>
        cart = getCartItemsFromCache();
        return cart;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCartLoading(false);
    }
    // return null;
  }

// ==========   Get Cart Items From Cache   ==========
  Cart? getCartItemsFromCache() {
    log("Future<Cart?> getCartItemsFromCache()");
    try {
      isCartLoading(true);
      cartItems(0);
      total(0.0);
      Cart myCart = Cart(products: []);
      //      ===>>>  Read From Cache ===>>>
      CacheHelper.getMyListCart().forEach((prod) {
        cartItems(cartItems.value += int.parse(prod.quantity.toString()));

        if (prod.special != null && prod.special != 0) {
          prod.priceRaw =
              double.parse(prod.special.toString()).toStringAsFixed(2);

          log("myProduct.priceRaw special  ${prod.priceRaw}");
        } else {
          prod.priceRaw = double.parse(prod.price.toString().split(',').join())
              .toStringAsFixed(2);
          log("myProduct.priceRaw price  ${prod.priceRaw}");
        }

        double priceRaw;
        if (prod.priceRaw == null) {
          priceRaw = double.parse("0.0");
        } else {
          priceRaw = double.parse(prod.priceRaw.toString());
        }
        total(total.value += (priceRaw * int.parse(prod.quantity.toString())));
        myCart.products!.add(prod);
      });

      cart = myCart;
      return cart;
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

  Future<bool> notifyMe({
    required String name,
    required String email,
    required String comment,
    required String productId,
  }) async {
    try {
      final isSuccess = await CheckoutService.notifyMe(
        name: name,
        email: email,
        comment: comment,
        productId: productId,
      );
      if (isSuccess) {
        print('success');
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
        //
        final gtmResult = await gtm.push(
          'purchase',
          parameters: {
            'transaction_id': order.orderId.toString(),
            'value': double.tryParse(order.total.toString()),
            'currency': 'SAR',
            // 'items': order.products!
            //     .map((e) => {
            //           'item_id': e.id.toString(),
            //           'item_name': e.name!,
            //           'price': double.tryParse(
            //               e.priceRaw * int.tryParse(e.quantity)),
            //           'currency': 'SAR',
            //           'quantity': int.tryParse(e.quantity.toString()),
            //         })
            //     .toList(),
          },
        );
        print(gtmResult);
        //
        AppsFlyerService.logPurchase(
          orderId: order.orderId.toString(),
          price: double.parse(order.total.toString()),
          currency: 'SAR',
          quantity: order.products!.length,
        );
        log("AppsFlyerService logPurchase price : ${double.parse(order.total.toString())}");
        await clearCart();
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
