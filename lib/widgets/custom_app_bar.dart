import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/cart_screen.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/product/controllers/product_controller.dart';
import 'package:aljouf/product/view/products_screen.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    this.showBackIcon = false,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool showBackIcon;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _searchController = TextEditingController();
  final _homeController = Get.put(HomeController());
  final _productsController = Get.put(ProductController());
  final _checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        height: 100,
        width: 100,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const CartScreen());
          },
          icon: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                color: primaryGreen,
                size: 24,
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                bottom: -15,
                end: 15,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryGreen,
                  ),
                  child: Obx(() {
                    return CustomText(
                      text: _checkoutController.cartItems.value.toString(),
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              if (Get.currentRoute == '/ProductsScreen') {
                AppUtil.dialog(
                  context,
                  'searchNow'.tr,
                  [
                    StatefulBuilder(builder: (context, setState) {
                      return SizedBox(
                        width: width,
                        child: Column(children: [
                          CustomTextField(
                            controller: _searchController,
                            hintText: 'searchKeyword'.tr,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                radius: 8,
                                width: width * 0.67,
                                onPressed: () {
                                  _productsController.page(1);
                                  _productsController.filteredProducts.clear();
                                  _productsController.getFilteredProducts(
                                    search: _searchController.text,
                                    categoryId: '',
                                    homeController: _homeController,
                                  );
                                  Get.back();
                                },
                                title: 'search'.tr,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                title: 'reset'.tr,
                                width: width * 0.2,
                                radius: 8,
                                onPressed: () {
                                  _searchController.clear();
                                  _productsController.page(1);
                                  _productsController.filteredProducts.clear();
                                  _productsController.getFilteredProducts(
                                    categoryId: '',
                                    homeController: _homeController,
                                  );
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ]),
                      );
                    }),
                  ],
                  alignment: Alignment.bottomCenter,
                );
              } else {
                Get.to(
                  () => ProductsScreen(
                    categoryId: '',
                    categoryName: 'allProducts'.tr,
                    isCategoryPage: false,
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.search_outlined,
              color: primaryGreen,
              size: 24,
            )),
        if (widget.showBackIcon)
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_forward_outlined,
              color: primaryGreen,
              size: 24,
            ),
          ),
      ],
      leading: IconButton(
        onPressed: () {
          widget.scaffoldKey.currentState!.openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: primaryGreen,
          size: 24,
        ),
      ),
    );
  }
}
