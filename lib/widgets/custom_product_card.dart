import 'dart:math' as math;
import 'package:aljouf/product/controllers/product_controller.dart';
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

  @override
  Widget build(BuildContext context) {
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
                      if (widget.product.quantity == 0)
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
                          if (widget.product.quantity == 0)
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
