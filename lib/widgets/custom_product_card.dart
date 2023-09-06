import 'dart:io';
import 'dart:math' as math;
import 'package:aljouf/auth/services/firebase_service.dart';
import 'package:aljouf/auth/view/edit_details_screen.dart';
import 'package:aljouf/auth/view/login_screen.dart';
import 'package:aljouf/auth/view/register_screen.dart';
import 'package:aljouf/home/services/apps_flyer_service.dart';
import 'package:aljouf/home/view/home_page.dart';
import 'package:aljouf/product/controllers/product_controller.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_card.dart';
import 'package:aljouf/widgets/custom_product_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/product/view/product_screen.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:get_storage/get_storage.dart';

class CustomProductCard extends StatefulWidget {
  const CustomProductCard({
    super.key,
    required this.product,
    required this.categoryId,
    this.isRelated = false,
    this.isFromProducts = false,
    this.isListViewLayout = false,
  });

  final Product product;
  final String categoryId;
  final bool isRelated;
  final bool isFromProducts;
  final bool isListViewLayout;

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  final _homeController = Get.put(HomeController());
  final _checkoutController = Get.put(CheckoutController());
  final _productController = Get.put(ProductController());
  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        if (widget.isRelated) {
          Get.back();
          Get.to(
            () => ProductScreen(
              product: widget.product,
              categoryId: widget.categoryId,
            ),
          );
        } else {
          Get.to(
            () => ProductScreen(
              product: widget.product,
              categoryId: widget.categoryId,
            ),
          );
        }
      },
      child: widget.isListViewLayout
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomProductBorder(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.product.originalImage!,
                        placeholder: (context, url) {
                          return const CustomLoadingWidget();
                        },
                      ),
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        top: 0,
                        end: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              widget.product.fav = !widget.product.fav!;
                            });
                            if (widget.product.fav!) {
                              _homeController.addToWishlist(
                                id: widget.product.id.toString(),
                                productController: _productController,
                              );
                            } else {
                              _homeController.deleteFromWishlist(
                                id: widget.product.id.toString(),
                                productController: _productController,
                              );
                            }
                          },
                          child: Icon(
                            widget.product.fav!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                widget.product.fav! ? vermillion : greenAccent,
                          ),
                        ),
                      ),
                      if (widget.product.quantity < 1)
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          top: AppUtil.rtlDirection(context) ? 4 : 10,
                          start: AppUtil.rtlDirection(context) ? -8 : -10,
                          child: Transform.rotate(
                            angle: AppUtil.rtlDirection(context)
                                ? math.pi / 5.0
                                : math.pi / -5.0,
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: vermillion,
                              ),
                              child: CustomText(
                                text: 'notAvailable'.tr,
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      if (widget.product.quantity != 0)
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          bottom: 0,
                          start: 0,
                          child: InkWell(
                            onTap: () async {
                              final getStorage = GetStorage();
                              final String? customerId =
                                  getStorage.read('customerId');
                              if (customerId != null &&
                                  customerId.isNotEmpty &&
                                  customerId ==
                                      _profileController.user.value.id
                                          .toString()) {
                                final isSuccess =
                                    await _checkoutController.addToCart(
                                  productId: widget.product.id.toString(),
                                  quantity: '1',
                                );
                                if (isSuccess) {
                                  if (context.mounted) {
                                    AppUtil.successToast(
                                      context,
                                      'productAddedToCart'.tr,
                                    );
                                  }
                                  AppsFlyerService.logAddToCart(
                                    id: widget.product.id.toString(),
                                    name: widget.product.name!,
                                    price: double.parse(
                                        widget.product.price.toString()),
                                    currency: 'SAR',
                                    quantity: 1,
                                  );
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
                                                title: CustomText(
                                                  text: 'signIn'.tr,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: warmGrey,
                                                ),
                                                content: SingleChildScrollView(
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                                                          CustomText(
                                                            text: 'loginThrough'
                                                                .tr,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: warmGrey,
                                                            textAlign: TextAlign
                                                                .center,
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
                                                        padding:
                                                            const EdgeInsets
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
                                                                child:
                                                                    CustomCard(
                                                                  onTap:
                                                                      () async {
                                                                    final user =
                                                                        await FirebaseService().signInWithApple(
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
                                                                            email:
                                                                                user.email,
                                                                            phone:
                                                                                user.phone,
                                                                            customerId:
                                                                                user.id.toString(),
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
                                                                onTap:
                                                                    () async {
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
                                                                      Get.offAll(
                                                                          () =>
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
                                                                          email:
                                                                              user.email,
                                                                          phone:
                                                                              user.phone,
                                                                          customerId: user
                                                                              .id
                                                                              .toString(),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                                icon:
                                                                    'google_icon',
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
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .grey[500]!,
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            CustomText(
                                                              text: 'joinUs'.tr,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            Colors.transparent,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white)),
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
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: greenAccent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(
                          text: widget.product.name!.split('&quot;').join(),
                          fontWeight: FontWeight.w400,
                          maxlines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                '${double.parse(widget.product.price.toString()).toStringAsFixed(2)} ',
                            style: TextStyle(
                              fontSize: widget.product.special != 0 ? 14 : 16,
                              fontWeight: widget.product.special != 0
                                  ? FontWeight.w400
                                  : FontWeight.w600,
                              color: Colors.black,
                              decoration: widget.product.special != 0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text: 'riyal'.tr,
                            style: TextStyle(
                              fontSize: widget.product.special != 0 ? 10 : 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]),
                      ),
                      if (widget.product.special != 0)
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  '${double.parse(widget.product.special.toString()).toStringAsFixed(2)} ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: vermillion,
                              ),
                            ),
                            TextSpan(
                              text: 'riyal'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: vermillion,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                        ),
                    ],
                  ),
                ),
              ],
            )
          : SizedBox(
              width: 195,
              child: CustomProductBorder(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CachedNetworkImage(
                            imageUrl: widget.product.originalImage!,
                            width: 170,
                            placeholder: (context, url) {
                              return const CustomLoadingWidget();
                            },
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            top: 0,
                            end: 0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.product.fav = !widget.product.fav!;
                                });
                                if (widget.product.fav!) {
                                  _homeController.addToWishlist(
                                    id: widget.product.id.toString(),
                                    productController: _productController,
                                  );
                                } else {
                                  _homeController.deleteFromWishlist(
                                    id: widget.product.id.toString(),
                                    productController: _productController,
                                  );
                                }
                              },
                              child: Icon(
                                widget.product.fav!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.product.fav!
                                    ? vermillion
                                    : greenAccent,
                              ),
                            ),
                          ),
                          if (widget.product.quantity < 1)
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              top: AppUtil.rtlDirection(context) ? 4 : 10,
                              start: AppUtil.rtlDirection(context) ? -8 : -10,
                              child: Transform.rotate(
                                angle: AppUtil.rtlDirection(context)
                                    ? math.pi / 5.0
                                    : math.pi / -5.0,
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: vermillion,
                                  ),
                                  child: CustomText(
                                    text: 'notAvailable'.tr,
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        right: 8,
                        left: 8,
                      ),
                      child: SizedBox(
                        width: 150,
                        child: CustomText(
                          text: widget.product.name!.split('&quot;').join(),
                          fontWeight: FontWeight.w400,
                          maxlines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        right: AppUtil.rtlDirection(context) ? 8 : 0,
                        left: AppUtil.rtlDirection(context) ? 0 : 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${double.parse(widget.product.price.toString()).toStringAsFixed(2)} ',
                                    style: TextStyle(
                                      fontSize:
                                          widget.product.special != 0 ? 14 : 16,
                                      fontWeight: widget.product.special != 0
                                          ? FontWeight.w400
                                          : FontWeight.w600,
                                      color: Colors.black,
                                      decoration: widget.product.special != 0
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'riyal'.tr,
                                    style: TextStyle(
                                      fontSize:
                                          widget.product.special != 0 ? 10 : 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]),
                              ),
                              if (widget.product.special != 0)
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text:
                                          '${double.parse(widget.product.special.toString()).toStringAsFixed(2)} ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: vermillion,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'riyal'.tr,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: vermillion,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ]),
                                ),
                            ],
                          ),
                          if (widget.product.quantity != 0)
                            InkWell(
                              onTap: () async {
                                final getStorage = GetStorage();
                                final String? customerId =
                                    getStorage.read('customerId');
                                if (customerId != null &&
                                    customerId.isNotEmpty &&
                                    customerId ==
                                        _profileController.user.value.id
                                            .toString()) {
                                  final isSuccess =
                                      await _checkoutController.addToCart(
                                    productId: widget.product.id.toString(),
                                    quantity: '1',
                                  );
                                  if (isSuccess) {
                                    if (context.mounted) {
                                      AppUtil.successToast(
                                        context,
                                        'productAddedToCart'.tr,
                                      );
                                    }
                                    AppsFlyerService.logAddToCart(
                                      id: widget.product.id.toString(),
                                      name: widget.product.name!,
                                      price: double.parse(
                                          widget.product.price.toString()),
                                      currency: 'SAR',
                                      quantity: 1,
                                    );
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
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  title: CustomText(
                                                    text: 'signIn'.tr,
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: warmGrey,
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    padding: const EdgeInsets
                                                            .symmetric(
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
                                                        const SizedBox(
                                                          height: 24,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              color:
                                                                  Colors.grey,
                                                              height: 1,
                                                              width: 99,
                                                            ),
                                                            CustomText(
                                                              text:
                                                                  'loginThrough'
                                                                      .tr,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: warmGrey,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Container(
                                                              color:
                                                                  Colors.grey,
                                                              height: 1,
                                                              width: 99,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 32,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
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
                                                              if (Platform
                                                                  .isIOS)
                                                                Expanded(
                                                                  child:
                                                                      CustomCard(
                                                                    onTap:
                                                                        () async {
                                                                      final user =
                                                                          await FirebaseService()
                                                                              .signInWithApple(context: context);
                                                                      if (user !=
                                                                          null) {
                                                                        _profileController
                                                                            .getAccount();
                                                                        _checkoutController
                                                                            .getCartItems();
                                                                        if (user.phone !=
                                                                                null &&
                                                                            user.phone!.isNotEmpty) {
                                                                          Get.offAll(() =>
                                                                              const HomePage());
                                                                        } else {
                                                                          Get.offAll(
                                                                            () =>
                                                                                EditDetailsScreen(
                                                                              profileController: _profileController,
                                                                              isFromSocialLogin: true,
                                                                              firstName: user.firstName,
                                                                              lastName: user.lastName,
                                                                              email: user.email,
                                                                              phone: user.phone,
                                                                              customerId: user.id.toString(),
                                                                            ),
                                                                          );
                                                                        }
                                                                      }
                                                                    },
                                                                    icon:
                                                                        'apple_icon',
                                                                  ),
                                                                ),
                                                              if (Platform
                                                                  .isIOS)
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                              Expanded(
                                                                child:
                                                                    CustomCard(
                                                                  onTap:
                                                                      () async {
                                                                    final user =
                                                                        await FirebaseService().signInWithGoogle(
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
                                                                            email:
                                                                                user.email,
                                                                            phone:
                                                                                user.phone,
                                                                            customerId:
                                                                                user.id.toString(),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                  },
                                                                  icon:
                                                                      'google_icon',
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
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .grey[500]!,
                                                              ),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              CustomText(
                                                                text:
                                                                    'joinUs'.tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                        BorderRadius.circular(
                                                            20),
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
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
                              child: const Icon(
                                Icons.add_shopping_cart,
                                color: greenAccent,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
