import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/widgets/custom_tracking_order_card.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.profileController.getUserOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBodyTitle(title: 'orders'.tr),
        Container(
          color: Colors.white,
          child: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            labelPadding: const EdgeInsets.symmetric(vertical: 12),
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
              if (_tabIndex == 1) {
                widget.profileController.getUserOrdersByStatus(
                  orderStatus: '3',
                );
              }
              if (_tabIndex == 2) {
                widget.profileController.getUserOrdersByStatus(
                  orderStatus: '5',
                );
              }
              // if (_tabIndex == 3) {
              //   widget.profileController.getUserOrdersByStatus(
              //     orderStatus: '17',
              //   );
              // }
            },
            tabs: [
              CustomText(
                text: 'all'.tr,
                color: _tabIndex == 0 ? primaryGreen : warmGrey,
                fontWeight: _tabIndex == 0 ? FontWeight.w400 : FontWeight.w300,
              ),
              CustomText(
                text: 'shipped'.tr,
                color: _tabIndex == 1 ? primaryGreen : warmGrey,
                fontWeight: _tabIndex == 1 ? FontWeight.w400 : FontWeight.w300,
              ),
              CustomText(
                text: 'completed'.tr,
                color: _tabIndex == 2 ? primaryGreen : warmGrey,
                fontWeight: _tabIndex == 2 ? FontWeight.w400 : FontWeight.w300,
              ),
              // CustomText(
              //   text: 'returned'.tr,
              //   color: _tabIndex == 3 ? black : warmGrey,
              //   fontWeight: _tabIndex == 3 ? FontWeight.w400 : FontWeight.w300,
              // ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              Obx(() {
                if (widget.profileController.isUserOrdersLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (widget.profileController.userOrders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/no_orders.json',
                        ),
                        CustomText(
                          text: 'noAvailableOrders'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.profileController.userOrders.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemBuilder: (context, index) {
                    return CustomTrackingOrderCard(
                      trackingOrder: widget.profileController.userOrders[index],
                    );
                  },
                );
              }),
              Obx(() {
                if (widget
                    .profileController.isUserOrdersByStatusLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (widget
                    .profileController.userOrdersByStatus.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/no_orders.json',
                        ),
                        CustomText(
                          text: 'noAvailableOrders'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.profileController.userOrdersByStatus.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemBuilder: (context, index) {
                    return CustomTrackingOrderCard(
                      trackingOrder:
                          widget.profileController.userOrdersByStatus[index],
                    );
                  },
                );
              }),
              Obx(() {
                if (widget
                    .profileController.isUserOrdersByStatusLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (widget
                    .profileController.userOrdersByStatus.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/no_orders.json',
                        ),
                        CustomText(
                          text: 'noAvailableOrders'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.profileController.userOrdersByStatus.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemBuilder: (context, index) {
                    return CustomTrackingOrderCard(
                      trackingOrder:
                          widget.profileController.userOrdersByStatus[index],
                    );
                  },
                );
              }),
              // Obx(() {
              //   if (widget
              //       .profileController.isUserOrdersByStatusLoading.value) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (widget
              //       .profileController.userOrdersByStatus.isEmpty) {
              //     return Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Lottie.asset(
              //             'assets/lottie/no_orders.json',
              //           ),
              //           CustomText(
              //             text: 'noAvailableOrders'.tr,
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400,
              //             textAlign: TextAlign.center,
              //           ),
              //         ],
              //       ),
              //     );
              //   }
              //   return ListView.separated(
              //     shrinkWrap: true,
              //     itemCount: widget.profileController.userOrdersByStatus.length,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 24,
              //     ),
              //     separatorBuilder: (context, index) {
              //       return const SizedBox(
              //         height: 16,
              //       );
              //     },
              //     itemBuilder: (context, index) {
              //       return CustomTrackingOrderCard(
              //         trackingOrder:
              //             widget.profileController.userOrdersByStatus[index],
              //       );
              //     },
              //   );
              // }),
            ],
          ),
        ),
      ],
    );
  }
}
