import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/profile/models/tracking_order.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomTrackingOrderCard extends StatelessWidget {
  const CustomTrackingOrderCard({
    super.key,
    required this.trackingOrder,
  });

  final TrackingOrder trackingOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: CachedNetworkImage(
                  imageUrl: trackingOrder.products!.first.originalImage!,
                  width: 60,
                  placeholder: (context, url) {
                    return const CustomLoadingWidget();
                  },
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${'orderNumber'.tr}  ',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: brownishGrey,
                        ),
                      ),
                      TextSpan(
                        text: trackingOrder.orderId!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${'items'.tr}  ',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: brownishGrey,
                        ),
                      ),
                      TextSpan(
                        text: trackingOrder.productTotal!.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              CustomText(
                text: trackingOrder.dateAdded!,
                color: brownishGrey,
                fontSize: 10,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  color: trackingOrder.status! == 'مكتمل'
                      ? jadeGreen
                      : trackingOrder.status! == 'إسترجاع'
                          ? brownishGrey
                          : trackingOrder.status! == 'تم شحن الطلب'
                              ? vermillion
                              : mango,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 14,
                ),
                child: CustomText(
                  text: trackingOrder.status!,
                  color: Colors.white,
                  fontSize: 10,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
