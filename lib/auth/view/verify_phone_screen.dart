import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/view/home_page.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({
    super.key,
    required this.customerId,
    required this.phone,
  });

  final String customerId;
  final String phone;

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 28,
          right: 28,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'verifyPhoneNumber'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryGreen,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppUtil.rtlDirection(context)
                          ? SvgPicture.asset(
                              'assets/icons/left_arrow.svg',
                              colorFilter: const ColorFilter.mode(
                                secondaryGreen,
                                BlendMode.srcIn,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/right_arrow.svg',
                              colorFilter: const ColorFilter.mode(
                                secondaryGreen,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 58,
              ),
              SvgPicture.asset('assets/icons/sms.svg'),
              const SizedBox(
                height: 25,
              ),
              CustomText(
                text: 'otpSent2'.tr,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '+966${widget.phone}',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 43,
              ),
              CustomTextField(
                controller: _codeController,
                hintText: 'verificationCode'.tr,
                textInputType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 4,
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(() {
                if (_authController.isVerifyOtpLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  radius: 4,
                  onPressed: () async {
                    final isSuccess = await _authController.verifyOTP(
                      customerId: widget.customerId,
                      phone: widget.phone,
                      otp: _codeController.text,
                      context: context,
                    );
                    if (isSuccess) {
                      Get.offAll(() => const HomePage());
                    }
                  },
                  title: 'verify'.tr,
                );
              }),
              const SizedBox(
                height: 36,
              ),
              Obx(() {
                if (_authController.isVerifyPhoneLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return InkWell(
                  onTap: () async {
                    await _authController.verifyPhone(
                      customerId: widget.customerId,
                      phone: widget.phone,
                      context: context,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/resend.svg',
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CustomText(
                        text: 'resendCode'.tr,
                        textAlign: TextAlign.center,
                        textDecoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
