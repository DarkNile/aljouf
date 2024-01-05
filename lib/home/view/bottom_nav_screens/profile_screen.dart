import 'package:aljouf/auth/view/change_password_screen.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:aljouf/auth/view/edit_details_screen.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/view/home_page.dart';
import 'package:aljouf/home/widgets/custom_profile_item.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/profile/view/address_screen.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.profileController,
    required this.authController,
    required this.checkoutController,
  });

  final ProfileController profileController;
  final AuthController authController;
  final CheckoutController checkoutController;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Obx(() {
      if (profileController.isProfileLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            CustomBodyTitle(title: 'profile'.tr),
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 95,
                //   color: lightGreen,
                // ),
                // Column(
                //   children: [
                Image.asset(
                  'assets/images/light-green-pattern-2.png',
                  width: MediaQuery.of(context).size.width,
                ),
                //     Image.asset(
                //       'assets/images/light-green-pattern-1.png',
                //       width: MediaQuery.of(context).size.width,
                //       height: 90,
                //     ),
                //   ],
                // ),
                Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'hello'.tr,
                                    color: brownishGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text:
                                        '${profileController.user.value.firstName!} ${profileController.user.value.lastName!}',
                                    color: black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text: profileController.user.value.email!,
                                    color: brownishGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text: profileController.user.value.phone!,
                                    textDirection: TextDirection.ltr,
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    authController.logout(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    decoration: const BoxDecoration(
                                        color: secondaryGreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: CustomText(
                                      text: 'logout'.tr,
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/person_icon.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            CustomProfileItem(
              onTap: () {
                Get.to(() => const AddressScreen());
              },
              title: 'SaveMyAddressTitle',
              subtitle: 'SaveMyAddressSubtitle',
              icon: 'Location (1)',
            ),
            CustomProfileItem(
              onTap: () {
                Get.offAll(
                  () => const HomePage(
                    pageIndex: 2,
                  ),
                );
              },
              title: 'registerPurchaseOrderTitle',
              subtitle: 'registerPurchaseOrderSubtitle',
              icon: 'Basket',
            ),
            // CustomProfileItem(
            //   onTap: () {
            //     Get.to(() => const WalletScreen());
            //   },
            //   title: 'walletBalance',
            //   subtitle: 'checkYourBalance',
            //   icon: 'wallet',
            // ),
            // CustomProfileItem(
            //   onTap: () {},
            //   title: 'returnProductTitle',
            //   subtitle: 'returnProductSubtitle',
            //   icon: 'replay',
            // ),
            // CustomProfileItem(
            //   onTap: () {},
            //   title: 'mailingListTitle',
            //   subtitle: 'mailingListSubtitle',
            //   icon: 'post_office',
            // ),
            CustomProfileItem(
              onTap: () {
                Get.to(
                  () => EditDetailsScreen(
                    profileController: profileController,
                  ),
                );
              },
              title: 'editDetailsTitle',
              subtitle: 'editDetailsSubtitle',
              icon: 'Adjustment',
            ),
            CustomProfileItem(
              onTap: () {
                Get.to(
                  () => ChangePasswordScreen(
                    email: profileController.user.value.email!,
                  ),
                );
              },
              title: 'changePassword',
              subtitle: 'changeOwnPassword',
              icon: 'Lock (1)',
            ),
            CustomProfileItem(
              onTap: () {
                AppUtil.dialog2(
                  context,
                  'deleteMyAccount'.tr,
                  [
                    CustomText(
                      text: 'confirmDelete'.tr,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                                authController.deleteAccount();
                              },
                              child: CustomText(
                                text: 'delete'.tr,
                                color: vermillion,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: CustomText(
                                text: 'cancel'.tr,
                                color: Colors.blue[700]!,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              },
              title: 'deleteMyAccount',
              subtitle: 'deleteMyOwnAccount',
              icon: 'Cancel Account',
              // leading: const Icon(
              //   Icons.person_off_outlined,
              //   color: black,
              // ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.11),
              child: Image.asset(
                'assets/images/Brush-line.png',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      );
    });
  }
}
