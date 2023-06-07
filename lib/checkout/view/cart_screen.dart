import 'dart:io';

import 'package:aljouf/auth/services/firebase_service.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aljouf/auth/view/login_screen.dart';
import 'package:aljouf/auth/view/register_screen.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/checkout_screen.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/view/home_screen.dart';
import 'package:aljouf/checkout/view/widgets/custom_cart_item.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_card.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _checkoutController = Get.put(CheckoutController());
  final _profileController = Get.put(ProfileController());

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _checkoutController.getCartItems();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
          color: darkBlack,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: darkBlack,
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
                border: Border.all(
                  color: almostBlack,
                ),
              ),
              child: CustomText(
                text: 'continueShopping'.tr,
                color: almostBlack,
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
                  return CustomCartItem(
                    product: _checkoutController.cart!.products![index],
                    checkoutController: _checkoutController,
                    onIncrementTap: () {
                      if (_checkoutController.cart!.products![index].qty !=
                          _checkoutController.cart!.products![index].quantity) {
                        setState(() {
                          _checkoutController.cart!.products![index].quantity =
                              (int.parse(_checkoutController
                                          .cart!.products![index].quantity) +
                                      1)
                                  .toString();
                        });
                        _checkoutController.updateCartItemQuantity(
                          productId: _checkoutController
                              .cart!.products![index].id
                              .toString(),
                          quantity: _checkoutController
                              .cart!.products![index].quantity
                              .toString(),
                        );
                      }
                    },
                    onDecrementTap: () {
                      if (_checkoutController.cart!.products![index].quantity !=
                          '1') {
                        setState(() {
                          _checkoutController.cart!.products![index].quantity =
                              (int.parse(_checkoutController
                                          .cart!.products![index].quantity) -
                                      1)
                                  .toString();
                        });
                        _checkoutController.updateCartItemQuantity(
                          productId: _checkoutController
                              .cart!.products![index].id
                              .toString(),
                          quantity: _checkoutController
                              .cart!.products![index].quantity
                              .toString(),
                        );
                      }
                    },
                    onDeleteTap: () {
                      _checkoutController.deleteCartItem(
                          productId: _checkoutController
                              .cart!.products![index].id
                              .toString());
                      setState(() {
                        _checkoutController.cart!.products!
                            .remove(_checkoutController.cart!.products![index]);
                      });
                    },
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
                height: height * 0.15,
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
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '${_checkoutController.total.value.toStringAsFixed(2)} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'riyal'.tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
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
                          final getStorage = GetStorage();
                          final String? customerId =
                              getStorage.read('customerId');
                          if (customerId != null &&
                              customerId.isNotEmpty &&
                              customerId ==
                                  _profileController.user.value.id.toString()) {
                            Get.to(() => const CheckoutScreen());
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
                                            title: CustomText(
                                              text: 'signIn'.tr,
                                              textAlign: TextAlign.center,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: warmGrey,
                                            ),
                                            content: SingleChildScrollView(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: ListBody(
                                                children: [
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
                                                  // const SizedBox(
                                                  //   height: 24,
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     Container(
                                                  //       color: Colors.grey,
                                                  //       height: 1,
                                                  //       width: 99,
                                                  //     ),
                                                  //     CustomText(
                                                  //       text: 'loginThrough'.tr,
                                                  //       fontWeight:
                                                  //           FontWeight.w400,
                                                  //       color: warmGrey,
                                                  //       textAlign:
                                                  //           TextAlign.center,
                                                  //     ),
                                                  //     Container(
                                                  //       color: Colors.grey,
                                                  //       height: 1,
                                                  //       width: 99,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 32,
                                                  // ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets
                                                  //           .symmetric(
                                                  //       horizontal: 4),
                                                  //   child: Row(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment
                                                  //             .spaceBetween,
                                                  //     textDirection:
                                                  //         TextDirection.ltr,
                                                  //     children: [
                                                  //       Expanded(
                                                  //         child: CustomCard(
                                                  //           onTap: () {},
                                                  //           icon:
                                                  //               'facebook_icon',
                                                  //         ),
                                                  //       ),
                                                  //       const SizedBox(
                                                  //         width: 8,
                                                  //       ),
                                                  //       if (Platform.isIOS)
                                                  //         Expanded(
                                                  //           child: CustomCard(
                                                  //             onTap: () async {
                                                  //               final user = await FirebaseService()
                                                  //                   .signInWithApple(
                                                  //                       context:
                                                  //                           context);
                                                  //               if (user !=
                                                  //                   null) {
                                                  //                   _profileController
                                                  //                       .getAccount();
                                                  //                   _checkoutController
                                                  //                       .getCartItems();
                                                  //                 Get.offAll(() =>
                                                  //                     const HomePage());
                                                  //               }
                                                  //             },
                                                  //             icon:
                                                  //                 'apple_icon',
                                                  //           ),
                                                  //         ),
                                                  //       if (Platform.isIOS)
                                                  //         const SizedBox(
                                                  //           width: 8,
                                                  //         ),
                                                  //       Expanded(
                                                  //         child: CustomCard(
                                                  //           onTap: () async {
                                                  //             final user = await FirebaseService()
                                                  //                 .signInWithGoogle(
                                                  //                     context:
                                                  //                         context);
                                                  //             if (user !=
                                                  //                 null) {
                                                  //                 _profileController
                                                  //                     .getAccount();
                                                  //                 _checkoutController
                                                  //                     .getCartItems();
                                                  //               Get.offAll(() =>
                                                  //                   const HomePage());
                                                  //             }
                                                  //           },
                                                  //           icon: 'google_icon',
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),
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
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
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
                        title: 'checkout'.tr,
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
