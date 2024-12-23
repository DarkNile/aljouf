// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:aljouf/auth/services/firebase_service.dart';
import 'package:aljouf/auth/view/edit_details_screen.dart';
import 'package:aljouf/home/services/apps_flyer_service.dart';
// import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/product/view/product_screen.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/utils/cache_helper.dart';
import 'package:aljouf/utils/debounce.dart';
import 'package:aljouf/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aljouf/auth/view/login_screen.dart';
import 'package:aljouf/auth/view/register_screen.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/checkout_screen.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/view/home_page.dart';
import 'package:aljouf/checkout/view/widgets/custom_cart_item.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:gtm/gtm.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _checkoutController = Get.put(CheckoutController());
  final _profileController = Get.put(ProfileController());
  final debounce = Debounce(const Duration(milliseconds: 500));
  final gtm = Gtm.instance;

  // final _homeController = Get.put(HomeController());

  // @override
  // void initState() {
  //   super.initState();
  //   _homeController.getCoupon();
  // }

  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    final getStorage = GetStorage();
    final String? customerId = getStorage.read('customerId');
    isLogin = (customerId != null &&
        customerId.isNotEmpty &&
        customerId == _profileController.user.value.id.toString());
  }

  calculateTotalForCachedProducts() {
    _checkoutController.cartItems(0);
    _checkoutController.total(0.0);
    for (var element in _checkoutController.cart!.products!) {
      _checkoutController.cartItems(_checkoutController.cartItems.value +=
          int.parse(element.quantity.toString()));
      _checkoutController.total(_checkoutController.total.value +=
          double.parse(element.priceRaw) *
              int.parse(element.quantity.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    log("CartScreen");

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'shoppingCart'.tr,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: secondaryGreen,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_outlined, color: secondaryGreen
              // black,
              ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.offAll(() => const HomePage());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 14,
              ).copyWith(
                left: 15,
                right: 15,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10.5,
                horizontal: 21.5,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: secondaryGreen
                    //  black,
                    ),
              ),
              child: CustomText(
                text: 'continueShopping'.tr,
                color: secondaryGreen,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (_checkoutController.isCartLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_checkoutController.cart == null ||
            _checkoutController.cart!.products!.isEmpty) {
          return Column(
            children: [
              CustomBodyTitle(title: '${'purchases'.tr} ( 0 )'),
              SizedBox(
                height: height * 0.05,
              ),
              Lottie.asset(
                'assets/lottie/empty_cart.json',
              ),
              CustomText(
                text: 'emptyCart'.tr,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
        return Column(
          children: [
            CustomBodyTitle(
                title:
                    '${'purchases'.tr} ( ${_checkoutController.cartItems.value.toString()} )'),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _checkoutController.cart!.products!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await gtm.push(
                        'view_item',
                        parameters: {
                          'item_id': _checkoutController
                              .cart!.products![index].id
                              .toString(),
                          'item_name': _checkoutController
                              .cart!.products![index].name!
                              .split('-')
                              .join()
                              .replaceAll('"', ''),
                          'price': double.tryParse((_checkoutController
                                          .cart!.products![index].special !=
                                      null &&
                                  _checkoutController
                                          .cart!.products![index].special !=
                                      0)
                              ? _checkoutController
                                  .cart!.products![index].special
                                  .toString()
                                  .split(',')
                                  .join()
                              : _checkoutController.cart!.products![index].price
                                  .toString()
                                  .split(',')
                                  .join()),
                        },
                      );
                      //
                      AppsFlyerService.appsflyerSdk.logEvent(
                        'af_content_view',
                        {
                          'af_content_id': _checkoutController
                              .cart!.products![index].id
                              .toString(),
                          'af_content_type':
                              _checkoutController.cart!.products![index].name!,
                          'af_price': double.parse((_checkoutController
                                          .cart!.products![index].special !=
                                      null &&
                                  _checkoutController
                                          .cart!.products![index].special !=
                                      0)
                              ? _checkoutController
                                  .cart!.products![index].special
                                  .toString()
                                  .split(',')
                                  .join()
                              : _checkoutController.cart!.products![index].price
                                  .toString()
                                  .split(',')
                                  .join()),
                        },
                      );
                      Get.to(
                        () => ProductScreen(
                          product: _checkoutController.cart!.products![index],
                          categoryId: '',
                          isFromCart: true,
                        ),
                      );
                    },
                    child: CustomCartItem(
                      product: _checkoutController.cart!.products![index],
                      checkoutController: _checkoutController,
                      onIncrementTap: () {
                        if (_checkoutController.cart!.products![index].qty !=
                            _checkoutController
                                .cart!.products![index].quantity) {
                          setState(() {
                            _checkoutController.cart!.products![index]
                                .quantity = (int.parse(_checkoutController
                                        .cart!.products![index].quantity) +
                                    1)
                                .toString();
                          });

                          log("SET");
                          var productsID = _checkoutController
                              .cart!.products![index].id
                              .toString();
                          log("productsID $productsID");
                          var quantity = _checkoutController
                              .cart!.products![index].quantity
                              .toString()
                              .toString();
                          log("quantity $quantity");

                          debounce.run(() {
                            if (isLogin) {
                              _checkoutController.updateCartItemQuantity(
                                productId: _checkoutController
                                    .cart!.products![index].id
                                    .toString(),
                                quantity: _checkoutController
                                    .cart!.products![index].quantity
                                    .toString(),
                              );
                            } else {
                              CacheHelper.upDateCart(
                                product:
                                    _checkoutController.cart!.products![index],
                                quantity: _checkoutController
                                    .cart!.products![index].quantity
                                    .toString(),
                              );
                              calculateTotalForCachedProducts();
                            }
                          });
                        }
                      },
                      onDecrementTap: () {
                        if (_checkoutController
                                .cart!.products![index].quantity !=
                            '1') {
                          setState(() {
                            _checkoutController.cart!.products![index]
                                .quantity = (int.parse(_checkoutController
                                        .cart!.products![index].quantity) -
                                    1)
                                .toString();
                          });
                          log("SET");
                          debounce.run(() {
                            if (isLogin) {
                              _checkoutController.updateCartItemQuantity(
                                productId: _checkoutController
                                    .cart!.products![index].id
                                    .toString(),
                                quantity: _checkoutController
                                    .cart!.products![index].quantity
                                    .toString(),
                              );
                            } else {
                              CacheHelper.upDateCart(
                                product:
                                    _checkoutController.cart!.products![index],
                                quantity: _checkoutController
                                    .cart!.products![index].quantity
                                    .toString(),
                              );
                              calculateTotalForCachedProducts();
                            }
                          });
                        }
                      },
                      onDeleteTap: () async {
                        log("DELETE");
                        if (isLogin) {
                          _checkoutController.deleteCartItem(
                              productId: _checkoutController
                                  .cart!.products![index].id
                                  .toString());
                          setState(() {
                            _checkoutController.cart!.products!.remove(
                                _checkoutController.cart!.products![index]);
                          });
                        } else {
                          CacheHelper.deleteFromCart(
                              product:
                                  _checkoutController.cart!.products![index]);
                          setState(() {
                            _checkoutController.cart!.products!.remove(
                                _checkoutController.cart!.products![index]);
                          });
                          calculateTotalForCachedProducts();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_checkoutController.cart!.products != null &&
                _checkoutController.cart!.products!.isNotEmpty)
              Container(
                width: width,
                height: height * 0.16,
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: width,
                    //     height: 36,
                    //     alignment: Alignment.center,
                    //     decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(16)),
                    //       color: lightGreen,
                    //     ),
                    //     child: CustomText(
                    //       text: 'congratulations'.tr,
                    //       fontWeight: FontWeight.w400,
                    //       color: darkGreen,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'total'.tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: primaryGreen,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '${_checkoutController.total.value.toStringAsFixed(2)} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryGreen,
                                ),
                              ),
                              TextSpan(
                                text: 'riyal'.tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: primaryGreen,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CustomButton(
                        onPressed: () async {
                          Map<String, dynamic> payload = {};
                          for (int i = 0;
                              i < _checkoutController.cart!.products!.length;
                              i++) {
                            final product =
                                _checkoutController.cart!.products![i];
                            final price = double.tryParse(
                                    product.priceRaw?.toString() ?? '0') ??
                                0.0;
                            final quantity = int.tryParse(
                                    product.quantity?.toString() ?? '1') ??
                                1;
                            int index = i + 1; // Start index from 1
                            payload['item_id_$index'] =
                                product.id?.toString() ?? 'Unknown ID';
                            payload['item_name_$index'] = product.name!
                                .split('-')
                                .join()
                                .replaceAll('"', '');
                            payload['price_$index'] = price;
                            payload['quantity_$index'] = quantity;
                          }
                          print('payload $payload');
                          //
                          final value = double.tryParse(
                                  _checkoutController.total.value.toString()) ??
                              0.0;
                          final gtmResult = await gtm.push(
                            'purchase',
                            parameters: {
                              'transaction_id': '999999',
                              'value': value,
                              'currency': 'SAR',
                              ...payload, // Spread the items payload here
                            },
                          );
                          print('GTM Result: $gtmResult');
                          // 'ecommerce': {
                          //   'items': [payload]
                          // }
                          // 'ecommerce': {
                          //   'ecommerce.items': payload,
                          // }
                          final getStorage = GetStorage();
                          final String? customerId =
                              getStorage.read('customerId');
                          if (customerId != null &&
                              customerId.isNotEmpty &&
                              customerId ==
                                  _profileController.user.value.id.toString()) {
                            final cart =
                                await _checkoutController.getCartItems();
                            for (int i = 0; i < cart!.products!.length; i++) {
                              if (cart.products![i].qty == '0' ||
                                  cart.products![i].qty == 0) {
                                _checkoutController.isOutOfStock(true);
                              } else {
                                _checkoutController.isOutOfStock(false);
                              }
                            }
                            if (_checkoutController.isOutOfStock.value ==
                                    true &&
                                context.mounted) {
                              AppUtil.errorToast(context, 'outOfStock'.tr);
                            } else {
                              Get.to(() => const CheckoutScreen());
                            }
                          } else {
                            await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return SizedBox(
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.all(16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerEnd,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  CustomText(
                                                    text: 'signIn'.tr,
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: warmGrey,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  CustomButton(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          const LoginScreen());
                                                    },
                                                    title: 'signIn'.tr,
                                                    radius: 4,
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        color: Colors.grey,
                                                        height: 1,
                                                        width: 99,
                                                      ),
                                                      Expanded(
                                                        child: CustomText(
                                                          text:
                                                              'loginThrough'.tr,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: warmGrey,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Container(
                                                        color: Colors.grey,
                                                        height: 1,
                                                        width: 99,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      children: [
                                                        // Expanded(
                                                        //   child: CustomCard(
                                                        //     onTap: () {},
                                                        //     icon:
                                                        //         'facebook_icon',
                                                        //   ),
                                                        // ),
                                                        // const SizedBox(
                                                        //   width: 8,
                                                        // ),
                                                        if (Platform.isIOS)
                                                          Expanded(
                                                            child: CustomCard(
                                                              onTap: () async {
                                                                final user = await FirebaseService()
                                                                    .signInWithApple(
                                                                        context:
                                                                            context);
                                                                if (user !=
                                                                    null) {
                                                                  _profileController
                                                                      .getAccount();
                                                                  _checkoutController
                                                                      .getCartItems();
                                                                  if (user.phone !=
                                                                          null &&
                                                                      user.phone!
                                                                          .isNotEmpty) {
                                                                    Get.offAll(() =>
                                                                        const HomePage());
                                                                  } else {
                                                                    Get.offAll(
                                                                      () =>
                                                                          EditDetailsScreen(
                                                                        profileController:
                                                                            _profileController,
                                                                        isFromSocialLogin:
                                                                            true,
                                                                        firstName:
                                                                            user.firstName,
                                                                        lastName:
                                                                            user.lastName,
                                                                        email: user
                                                                            .email,
                                                                        phone: user
                                                                            .phone,
                                                                        customerId: user
                                                                            .id
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                              icon:
                                                                  'apple_icon',
                                                            ),
                                                          ),
                                                        if (Platform.isIOS)
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                        Expanded(
                                                          child: CustomCard(
                                                            onTap: () async {
                                                              final user = await FirebaseService()
                                                                  .signInWithGoogle(
                                                                      context:
                                                                          context);
                                                              if (user !=
                                                                  null) {
                                                                _profileController
                                                                    .getAccount();
                                                                _checkoutController
                                                                    .getCartItems();
                                                                if (user.phone !=
                                                                        null &&
                                                                    user.phone!
                                                                        .isNotEmpty) {
                                                                  Get.offAll(() =>
                                                                      const HomePage());
                                                                } else {
                                                                  Get.offAll(
                                                                    () =>
                                                                        EditDetailsScreen(
                                                                      profileController:
                                                                          _profileController,
                                                                      isFromSocialLogin:
                                                                          true,
                                                                      firstName:
                                                                          user.firstName,
                                                                      lastName:
                                                                          user.lastName,
                                                                      email: user
                                                                          .email,
                                                                      phone: user
                                                                          .phone,
                                                                      customerId: user
                                                                          .id
                                                                          .toString(),
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            icon: 'google_icon',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          const RegisterScreen());
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomText(
                                                          text:
                                                              'dontHaveAccount'
                                                                  .tr,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Colors.grey[500]!,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        CustomText(
                                                          text: 'joinUs'.tr,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                });
                          }
                        },
                        color: _checkoutController.isOutOfStock.value == true
                            ? brownishGrey
                            : secondaryGreen,
                        title: _checkoutController.isOutOfStock.value == true
                            ? 'outOfStock'.tr
                            : 'checkout'.tr,
                        radius: 4,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }
}
