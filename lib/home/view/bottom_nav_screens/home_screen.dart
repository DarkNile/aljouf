import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/product/view/products_screen.dart';
import 'package:aljouf/widgets/custom_animated_smooth_indicator.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.homeController});

  final HomeController homeController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (widget.homeController.isBannersLoading.value) {
              return SizedBox(
                width: width,
                height: 361,
                child: const CustomLoadingWidget(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                    itemCount: widget.homeController.banners.length,
                    options: CarouselOptions(
                      height: 361,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _activeIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, page) {
                      return CachedNetworkImage(
                        imageUrl: widget.homeController.banners[index]['image'],
                        width: width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return const CustomLoadingWidget();
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: CustomAnimatedSmoothIndicator(
                    count: widget.homeController.banners.length,
                    activeIndex: _activeIndex,
                    isBlack: true,
                  ),
                ),
              ],
            );
          }),
          const SizedBox(
            height: 24,
          ),
          Obx(() {
            if (widget.homeController.isCategoryProductsLoading.value) {
              return const SizedBox(
                height: 300,
              );
            } else if (widget.homeController.offers.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: widget.homeController.categories
                            .where((element) => element.id == 221)
                            .first
                            .name,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductsScreen(
                              categoryId: '221',
                              categoryName: widget.homeController.categories
                                  .where((element) => element.id == 221)
                                  .first
                                  .name,
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'viewAll'.tr,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.homeController.offers.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomProductCard(
                          product: widget.homeController.offers[index],
                          categoryId: '221',
                        );
                      }),
                ),
              ],
            );
          }),
          // if (widget.homeController.offers.isNotEmpty)
          const SizedBox(
            height: 24,
          ),
          Obx(() {
            if (widget.homeController.isBannersLoading.value) {
              return const SizedBox(
                height: 190,
              );
            } else if (widget.homeController.organicOliveOil.isEmpty &&
                widget.homeController.goldenOlive.isEmpty &&
                widget.homeController.jofoliaOliveOil.isEmpty) {
              return Container();
            }
            return Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -20,
                  child: Image.asset(
                    'assets/images/light-green-pattern-2.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.homeController.oliveOilBanner.first['image'],
                      width: width,
                      fit: BoxFit.cover,
                      height: 190,
                      placeholder: (context, url) {
                        return const CustomLoadingWidget();
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
          if (widget.homeController.organicOliveOil.isNotEmpty ||
              widget.homeController.goldenOlive.isNotEmpty ||
              widget.homeController.jofoliaOliveOil.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          Obx(() {
            if (widget.homeController.isCategoryProductsLoading.value) {
              return const SizedBox(
                height: 300,
              );
            } else if (widget.homeController.organicOliveOil.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'organic'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductsScreen(
                              categoryId: '107',
                              categoryName: 'organic'.tr,
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'viewAll'.tr,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.homeController.organicOliveOil.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomProductCard(
                          product: widget.homeController.organicOliveOil[index],
                          categoryId: '107',
                        );
                      }),
                ),
              ],
            );
          }),
          if (widget.homeController.organicOliveOil.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          Obx(() {
            if (widget.homeController.isCategoryProductsLoading.value) {
              return const SizedBox(
                height: 300,
              );
            } else if (widget.homeController.goldenOlive.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'golden'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductsScreen(
                              categoryId: '225',
                              categoryName: 'golden'.tr,
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'viewAll'.tr,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.homeController.goldenOlive.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomProductCard(
                          product: widget.homeController.goldenOlive[index],
                          categoryId: '225',
                        );
                      }),
                ),
              ],
            );
          }),
          if (widget.homeController.goldenOlive.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          Obx(() {
            if (widget.homeController.isCategoryProductsLoading.value) {
              return const SizedBox(
                height: 300,
              );
            } else if (widget.homeController.jofoliaOliveOil.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'jofolia'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductsScreen(
                              categoryId: '226',
                              categoryName: 'jofolia'.tr,
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'viewAll'.tr,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.homeController.jofoliaOliveOil.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomProductCard(
                          product: widget.homeController.jofoliaOliveOil[index],
                          categoryId: '226',
                        );
                      }),
                ),
              ],
            );
          }),
          // if (widget.homeController.jofoliaOliveOil.isNotEmpty)
          const SizedBox(
            height: 24,
          ),
          // Obx(() {
          //   if (widget.homeController.isCategoriesLoading.value ||
          //       widget.homeController.isCategoryProductsLoading.value ||
          //       widget.homeController.isWishListProductsLoading.value) {
          //     return Container();
          //   }
          //   return Column(
          //     children: [
          //       TabBar(
          //         indicatorSize: TabBarIndicatorSize.label,
          //         indicatorWeight: 1,
          //         labelPadding: const EdgeInsets.only(bottom: 8),
          //         physics: const NeverScrollableScrollPhysics(),
          //         controller: _tabController,
          //         onTap: (index) {
          //           setState(() {
          //             _tabIndex = index;
          //           });
          //         },
          //         tabs: [
          //           CustomText(
          //             text: 'jofolia'.tr,
          //             fontSize: 14,
          //             fontWeight:
          //                 _tabIndex == 0 ? FontWeight.w500 : FontWeight.w400,
          //           ),
          //           CustomText(
          //             text: 'golden'.tr,
          //             fontSize: 14,
          //             fontWeight:
          //                 _tabIndex == 1 ? FontWeight.w500 : FontWeight.w400,
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 12,
          //       ),
          //       SizedBox(
          //         height: 250,
          //         child: TabBarView(
          //             physics: const NeverScrollableScrollPhysics(),
          //             controller: _tabController,
          //             children: [
          //               ListView.separated(
          //                   padding: const EdgeInsets.symmetric(horizontal: 12),
          //                   shrinkWrap: true,
          //                   scrollDirection: Axis.horizontal,
          //                   itemCount:
          //                       widget.homeController.jofoliaOliveOil.length,
          //                   separatorBuilder: (context, index) {
          //                     return const SizedBox(
          //                       width: 8,
          //                     );
          //                   },
          //                   itemBuilder: (context, index) {
          //                     return CustomProductCard(
          //                       product: widget
          //                           .homeController.jofoliaOliveOil[index],
          //                       categoryId: '226',
          //                     );
          //                   }),
          //               ListView.separated(
          //                   padding: const EdgeInsets.symmetric(horizontal: 12),
          //                   shrinkWrap: true,
          //                   scrollDirection: Axis.horizontal,
          //                   itemCount: widget.homeController.goldenOlive.length,
          //                   separatorBuilder: (context, index) {
          //                     return const SizedBox(
          //                       width: 8,
          //                     );
          //                   },
          //                   itemBuilder: (context, index) {
          //                     return CustomProductCard(
          //                       product:
          //                           widget.homeController.goldenOlive[index],
          //                       categoryId: '225',
          //                     );
          //                   }),
          //             ]),
          //       ),
          //     ],
          //   );
          // }),
          Obx(() {
            if (widget.homeController.isBannersLoading.value) {
              return const SizedBox(
                height: 190,
              );
            } else if (widget.homeController.olive.isEmpty) {
              return Container();
            }
            return Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -20,
                  child: Image.asset(
                    'assets/images/light-green-pattern-2.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.homeController.oliveBanner.first['image'],
                      width: width,
                      height: 190,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const CustomLoadingWidget();
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
          if (widget.homeController.olive.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          Obx(() {
            if (widget.homeController.isCategoryProductsLoading.value) {
              return const SizedBox(
                height: 300,
              );
            } else if (widget.homeController.olive.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: widget.homeController.categories
                            .where((element) => element.id == 166)
                            .first
                            .name,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductsScreen(
                              categoryId: '166',
                              categoryName: widget.homeController.categories
                                  .where((element) => element.id == 166)
                                  .first
                                  .name,
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'viewAll'.tr,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.homeController.olive.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomProductCard(
                          product: widget.homeController.olive[index],
                          categoryId: '166',
                        );
                      }),
                ),
              ],
            );
          }),
          if (widget.homeController.olive.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          const SizedBox(
            height: 24,
          ),
          Obx(() {
            if (widget.homeController.isBannersLoading.value) {
              return const SizedBox(
                height: 190,
              );
            } else if (widget.homeController.honey.isEmpty) {
              return Container();
            }
            return Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -20,
                  child: Image.asset(
                    'assets/images/light-green-pattern-2.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.homeController.honeyBanner.first['image'],
                      width: width,
                      height: 190,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const CustomLoadingWidget();
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
          if (widget.homeController.honey.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          Obx(() {
            if (widget.homeController.isCategoryProductsLoading.value) {
              return const SizedBox(
                height: 300,
              );
            } else if (widget.homeController.honey.isEmpty) {
              return Container();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: widget.homeController.categories
                            .where((element) => element.id == 109)
                            .first
                            .name,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductsScreen(
                              categoryId: '109',
                              categoryName: widget.homeController.categories
                                  .where((element) => element.id == 109)
                                  .first
                                  .name,
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'viewAll'.tr,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.homeController.honey.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomProductCard(
                          product: widget.homeController.honey[index],
                          categoryId: '109',
                        );
                      }),
                ),
              ],
            );
          }),
          // if (widget.homeController.honey.isNotEmpty)
          const SizedBox(
            height: 24,
          ),
          Image.asset(
            'assets/images/Brush-line.png',
            width: MediaQuery.of(context).size.width,
          ),
          // Container(
          //   width: width,
          //   height: 300,
          //   color: lighGrey,
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          //         child: CustomText(
          //           text: 'shopAndEnjoy'.tr,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Expanded(
          //               child: CustomFeatureCard(
          //                   icon: 'delivery',
          //                   title: 'freeShipping'.tr,
          //                   subtitle: 'deliveryThreeDays'.tr),
          //             ),
          //             const SizedBox(
          //               width: 10,
          //             ),
          //             Expanded(
          //               child: CustomFeatureCard(
          //                   icon: 'cash',
          //                   title: 'cashOnArrival'.tr,
          //                   subtitle: 'payInCash'.tr),
          //             ),
          //             const SizedBox(
          //               width: 10,
          //             ),
          //             Expanded(
          //               child: CustomFeatureCard(
          //                   icon: 'reload',
          //                   title: 'return'.tr,
          //                   subtitle: 'freeReturn'.tr),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
