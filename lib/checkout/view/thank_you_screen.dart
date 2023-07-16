import 'package:aljouf/constants/extensions.dart';
import 'package:aljouf/home/services/rating_service.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/view/home_page.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({
    super.key,
    required this.orderId,
    required this.email,
  });

  final int orderId;
  final String email;

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2,),() => showRatingPopup(),);
    super.initState();
  }

  showRatingPopup() =>
  AppUtil.dialog2(
    context,
    'appRating'.tr,
    [
      CustomText(
        text: 'ratingDialog'.tr,
        textAlign: TextAlign.start,
      ),
      20.ph,
      Center(
        child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          ignoreGestures: true,
          tapOnlyMode: true,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: 25,
          itemPadding:
          const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
          //  this.rating = rating.toInt();
            print(rating);
          },
        ),
      ),
      10.ph,
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomOutlinedButton(
            onPressed: () {
              RatingService().showRating();
            },
            child: Text(
              'rating'.tr,
              style: const TextStyle(color: jadeGreen),
            ),
            backgroundColor: Colors.transparent),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAll(() => const HomePage());
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Center(
                  child: CustomText(
                    text: 'confirmByEmail'.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: CustomText(
                    text: widget.email,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/preparing_order.json',
                    width: 300,
                    height: 300,
                  ),
                  const CustomText(
                    text: 'جاري تجهيز طلبك',
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'orderNumber'.tr,
                      color: brownishGrey,
                      fontSize: 10,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomText(
                      text: widget.orderId.toString(),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomText(
                  text: 'trackYourOrder'.tr,
                  color: brownishGrey,
                  fontSize: 10,
                ),
              ],
            ),
            CustomButton(
                onPressed: () {
                  Get.offAll(() => const HomePage(
                        pageIndex: 2,
                      ));
                },
                title: 'myOrdersHistory'.tr),
          ],
        ),
      ),
    );
  }
}
