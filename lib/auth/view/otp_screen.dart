import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:aljouf/auth/view/change_password_screen.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    this.password,
    this.passwordConfirmation,
  });

  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String? password;
  final String? passwordConfirmation;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
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
                      text: 'verifyEmailAddress'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppUtil.rtlDirection(context)
                          ? SvgPicture.asset('assets/icons/left_arrow.svg')
                          : SvgPicture.asset('assets/icons/right_arrow.svg'),
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
                text: 'otpSent'.tr,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.email,
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
                if (_authController.isOTPLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  radius: 4,
                  onPressed: () async {
                    final isSuccess = await _authController.checkOTP(
                      email: widget.email,
                      activationCode: _codeController.text,
                      context: context,
                    );
                    if (isSuccess) {
                      Get.to(() => ChangePasswordScreen(email: widget.email));
                    }
                  },
                  title: 'verify'.tr,
                );
              }),
              const SizedBox(
                height: 36,
              ),
              Obx(() {
                if (_authController.isForgetPasswordLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return InkWell(
                  onTap: () async {
                    await _authController.forgetPass(
                      email: widget.email,
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
