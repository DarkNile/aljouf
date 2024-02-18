import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/checkout_tabs/order_summary_page.dart';
import 'package:aljouf/checkout/view/checkout_tabs/payment_method_page.dart';
import 'package:aljouf/checkout/view/checkout_tabs/shipping_address_page.dart';
import 'package:aljouf/checkout/view/checkout_tabs/shipping_method_page.dart';
import 'package:aljouf/checkout/view/thank_you_screen.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_header.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with TickerProviderStateMixin {
  final _checkoutController = Get.put(CheckoutController());
  final _profileController = Get.put(ProfileController());
  final _homeController = Get.put(HomeController());
  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getAddress(context: context);
      _profileController.getCountries();
      _profileController.getZones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _tabIndex == 3 ? null : Colors.white,
      appBar: CustomHeader(
        onTapBack: () {
          if (_tabIndex == 0) {
            Get.back();
          } else {
            setState(() {
              _tabIndex = _tabIndex - 1;
            });
            _tabController.animateTo(_tabIndex);
          }
        },
        title: _tabIndex == 0
            ? 'shippingAddress'.tr
            : _tabIndex == 1
                ? 'shippingMethod'.tr
                : _tabIndex == 2
                    ? 'paymentMethod'.tr
                    : 'orderSummary'.tr,
      ),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: width,
                height: 1,
                color: lightGreen,
              ),
              IgnorePointer(
                child: TabBar(
                  indicator: const BoxDecoration(),
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  tabs: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 0
                            ? secondaryGreen
                            : _tabIndex == 0
                                ? primaryGreen
                                : Colors.white,
                        border: _tabIndex == 0 || _tabIndex > 0
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 0
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '1',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 0 ? Colors.white : warmGrey,
                            ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 1
                            ? secondaryGreen
                            : _tabIndex == 1
                                ? primaryGreen
                                : Colors.white,
                        border: _tabIndex == 1 || _tabIndex > 1
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 1
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '2',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 1 ? Colors.white : warmGrey,
                            ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 2
                            ? secondaryGreen
                            : _tabIndex == 2
                                ? primaryGreen
                                : Colors.white,
                        border: _tabIndex == 2 || _tabIndex > 2
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 2
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '3',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 2 ? Colors.white : warmGrey,
                            ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 3
                            ? secondaryGreen
                            : _tabIndex == 3
                                ? primaryGreen
                                : Colors.white,
                        border: _tabIndex == 3 || _tabIndex > 3
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 3
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '4',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 3 ? Colors.white : warmGrey,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomBodyTitle(
            title: _tabIndex == 0
                ? 'shippingAddress'.tr
                : _tabIndex == 1
                    ? 'shippingMethod'.tr
                    : _tabIndex == 2
                        ? 'paymentMethod'.tr
                        : 'orderSummary'.tr,
          ),
          if (_tabIndex != 3)
            const SizedBox(
              height: 16,
            ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Obx(() {
                  if (_profileController.isAddressLoading.value ||
                      _profileController.isCountriesLoading.value ||
                      _profileController.isZonesLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ShippingAddressPage(
                    checkoutController: _checkoutController,
                    profileController: _profileController,
                    onNextTap: (checkedIndex) async {
                      final isSuccess =
                          await _checkoutController.addShippingAddress(
                        context: context,
                        addressId: int.parse(
                          _profileController.addresses[checkedIndex].id,
                        ),
                      );
                      if (isSuccess) {
                        if (context.mounted) {
                          _checkoutController.getShippingMethods(
                              context: context);
                          _checkoutController.getShippingRate();
                        }
                        setState(() {
                          _tabIndex = 1;
                        });
                        _tabController.animateTo(1);
                      }
                    },
                  );
                }),
                Obx(() {
                  if (_checkoutController.isShippingMethodsLoading.value ||
                      _checkoutController.isShippingRateLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ShippingMethodPage(
                    checkoutController: _checkoutController,
                    onNextTap: (checkedIndex) async {
                      // String shippingRate = '';
                      // if (_checkoutController.shippingMethods[checkedIndex]
                      //     .quote.first.code.isNotEmpty) {
                      //   shippingRate = _checkoutController
                      //       .shippingMethods[checkedIndex].quote.first.code;
                      // } else {
                      if (_checkoutController.total.value >=
                          _checkoutController.shippingRate.value.toDouble()) {
                        // shippingRate = 'free.free';
                        _checkoutController.shippingCode('free.free');
                      } else {
                        // shippingRate = 'aramex.aramex';
                        _checkoutController.shippingCode('aramex.aramex');
                      }
                      //   }
                      print('Checkout Total ${_checkoutController.total}');
                      print(
                          'Max Shipping Cost: ${_checkoutController.shippingRate.value.toDouble()}');
                      print(
                          'Checkout Shipping Rate: ${_checkoutController.shippingCode}');
                      final isSuccess =
                          await _checkoutController.addShippingMethod(
                        context: context,
                        // shippingMethodCode: shippingRate,
                        shippingMethodCode:
                            _checkoutController.shippingCode.value,
                      );
                      if (isSuccess) {
                        if (context.mounted) {
                          _checkoutController.getPaymentMethods(
                              context: context);
                        }
                        setState(() {
                          _tabIndex = 2;
                        });
                        _tabController.animateTo(2);
                      }
                    },
                  );
                }),
                Obx(() {
                  if (_checkoutController.isPaymentMethodsLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return PaymentMethodPage(
                      checkoutController: _checkoutController,
                      onNextTap: (checkedIndex) async {
                        final isSuccess =
                            await _checkoutController.addPaymentMethod(
                          context: context,
                          paymentMethodCode: _checkoutController
                              .paymentMethods[checkedIndex].code,
                        );
                        if (isSuccess) {
                          if (context.mounted) {
                            // _homeController.getCoupon();
                            _checkoutController.confirmOrder(context: context);
                          }
                          setState(() {
                            _tabIndex = 3;
                          });
                          _tabController.animateTo(3);
                        }
                      });
                }),
                Obx(() {
                  if (
                      // _homeController.isCouponLoading.value ||
                      _checkoutController.isConfirmOrderLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return OrderSummaryPage(
                    checkoutController: _checkoutController,
                    homeController: _homeController,
                    onEditPurchasesTap: () {
                      Get.back();
                    },
                    onEditAddressTap: () {
                      setState(() {
                        _tabIndex = 0;
                      });
                      _tabController.animateTo(0);
                    },
                    onEditShippingTap: () {
                      setState(() {
                        _tabIndex = 1;
                      });
                      _tabController.animateTo(1);
                    },
                    onEditPaymentTap: () {
                      setState(() {
                        _tabIndex = 2;
                      });
                      _tabController.animateTo(2);
                    },
                    onConfirmOrderTap: () async {
                      print(_checkoutController.order!.paymentCode!);
                      if (_checkoutController.order!.paymentCode! ==
                          'paytabs_all') {
                        payWithVisa(
                          double.parse(_checkoutController.order!.total
                              .toStringAsFixed(2)),
                          _checkoutController.order!.orderId!.toString(),
                        );
                      } else {
                        applePay(
                          double.parse(_checkoutController.order!.total
                              .toStringAsFixed(2)),
                          _checkoutController.order!.orderId!.toString(),
                        );
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void payWithVisa(double amount, String orderId) {
    print('amount $amount');
    print('orderId $orderId');
    var configuration = PaymentSdkConfigurationDetails(
      profileId: "64604",
      serverKey: "SZJNMJHBT2-J6JRLZ2JJW-BBT62LGDMR",
      clientKey: "CVKMT9-VTRB6G-6RB9M6-DTDQG6",
      cartId: orderId,
      cartDescription: "Pay with Card",
      merchantName: "Al-Jouf Agricultural Development Company",
      screentTitle: "Pay with Card",
      locale: PaymentSdkLocale.AR,
      amount: amount,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      billingDetails: BillingDetails(
        '${_checkoutController.order!.shippingFirstName!} ${_checkoutController.order!.shippingLastName!}',
        _checkoutController.order!.email!,
        _checkoutController.order!.phone!,
        _checkoutController.order!.shippingAddress!,
        'SA',
        _checkoutController.order!.shippingCity!,
        _checkoutController.order!.shippingZone!,
        _checkoutController.order!.shippingZone!,
      ),
      shippingDetails: ShippingDetails(
        '${_checkoutController.order!.shippingFirstName!} ${_checkoutController.order!.shippingLastName!}',
        _checkoutController.order!.email!,
        _checkoutController.order!.phone!,
        _checkoutController.order!.shippingAddress!,
        'SA',
        _checkoutController.order!.shippingCity!,
        _checkoutController.order!.shippingZone!,
        _checkoutController.order!.shippingZone!,
      ),
    );
    FlutterPaytabsBridge.startCardPayment(configuration, (event) {
      print(event);
      setState(() {
        setState(() {
          if (event["status"] == "success") {
            var transactionDetails = event["data"];
            print(transactionDetails);
            print('${transactionDetails["isSuccess"]}');
            if (transactionDetails["isSuccess"]) {
              print("successful transaction");
              _checkoutController.saveOrderToDatabase(
                order: _checkoutController.order!,
              );
              Get.off(() => ThankYouScreen(
                    checkOutController: _checkoutController,
                    orderId: _checkoutController.order!.orderId!,
                    email: _checkoutController.order!.email!,
                  ));
            } else {
              print("failed transaction");
              AppUtil.errorToast(context, 'paymentFailed'.tr);
            }
          } else if (event["status"] == "error") {
            // Handle error here.
            print(event["status"]);
          } else if (event["status"] == "event") {
            // Handle cancel events here.
            print(event["status"]);
          }
        });
      });
    });
  }

  void applePay(double amount, String orderId) {
    print('amount $amount');
    print('orderId $orderId');
    var configuration = PaymentSdkConfigurationDetails(
      profileId: "64604",
      serverKey: "SZJNMJHBT2-J6JRLZ2JJW-BBT62LGDMR",
      clientKey: "CVKMT9-VTRB6G-6RB9M6-DTDQG6",
      cartId: orderId,
      cartDescription: "Pay via Apple Pay",
      merchantName: "Al-Jouf Agricultural Development Company",
      screentTitle: "Pay with Card",
      locale: PaymentSdkLocale.AR,
      amount: amount,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      merchantApplePayIndentifier: "merchant.com.DigitalPartner.aljouf",
      simplifyApplePayValidation: true,
      billingDetails: BillingDetails(
        '${_checkoutController.order!.shippingFirstName!} ${_checkoutController.order!.shippingLastName!}',
        _checkoutController.order!.email!,
        _checkoutController.order!.phone!,
        _checkoutController.order!.shippingAddress!,
        _checkoutController.order!.shippingCountry!,
        _checkoutController.order!.shippingCity!,
        _checkoutController.order!.shippingZone!,
        '',
      ),
      shippingDetails: ShippingDetails(
        '${_checkoutController.order!.shippingFirstName!} ${_checkoutController.order!.shippingLastName!}',
        _checkoutController.order!.email!,
        _checkoutController.order!.phone!,
        _checkoutController.order!.shippingAddress!,
        _checkoutController.order!.shippingCountry!,
        _checkoutController.order!.shippingCity!,
        _checkoutController.order!.shippingZone!,
        '',
      ),
    );
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        setState(() {
          if (event["status"] == "success") {
            var transactionDetails = event["data"];
            print(transactionDetails);
            print('${transactionDetails["isSuccess"]}');
            if (transactionDetails["isSuccess"]) {
              print("successful transaction");
              _checkoutController.saveOrderToDatabase(
                order: _checkoutController.order!,
              );
              Get.off(() => ThankYouScreen(
                    checkOutController: _checkoutController,
                    orderId: _checkoutController.order!.orderId!,
                    email: _checkoutController.order!.email!,
                  ));
            } else {
              print("failed transaction");
              AppUtil.errorToast(context, 'paymentFailed'.tr);
            }
          } else if (event["status"] == "error") {
            // Handle error here.
            print(event["status"]);
          } else if (event["status"] == "event") {
            // Handle cancel events here.
            print(event["status"]);
          }
        });
      });
    });
  }
}
