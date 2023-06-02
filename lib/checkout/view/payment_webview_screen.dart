import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/failure_screen.dart';
import 'package:aljouf/checkout/view/thank_you_screen.dart';
import 'package:aljouf/home/view/home_screen.dart';
import 'package:aljouf/widgets/custom_header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewScreen extends StatelessWidget {
  const PaymentWebviewScreen({
    super.key,
    required this.orderId,
    required this.email,
    required this.checkoutController,
  });

  final int orderId;
  final String email;
  final CheckoutController checkoutController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(title: 'confirmPayment'.tr),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
                'https://aljouf.com/index.php?route==rest/confirm/redirect_payfort&order_id=$orderId'),
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                print(progress);
              },
              onPageStarted: (String url) {
                print(url);
              },
              onPageFinished: (String url) {
                print(url);
              },
              onWebResourceError: (WebResourceError error) {
                print(error);
              },
              onNavigationRequest: (NavigationRequest request) async {
                print(request.url);

                if (request.url.contains('thankyou')) {
                  final isSuccess =
                      await checkoutController.saveOrderToDatabase();
                  if (isSuccess) {
                    Get.offAll(
                      () => ThankYouScreen(
                        orderId: orderId,
                        email: email,
                      ),
                    );
                  }
                }

                if (request.url.contains('failure')) {
                  Get.offAll(
                    () => const FailureScreen(),
                  );
                }

                if (request.url.contains('backToMerchant')) {
                  Get.offAll(
                    () => const HomePage(),
                  );
                }

                return NavigationDecision.navigate;
              },
            ),
          ),
      ),
    );
  }
}
