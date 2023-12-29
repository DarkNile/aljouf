import 'package:aljouf/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:aljouf/auth/view/login_screen.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';
import 'package:get_storage/get_storage.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final getStorage = GetStorage();
  final _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isPasswordConfirmationHidden = true;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'resetPassword'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
                height: 70,
              ),
              CustomText(
                text: 'password'.tr,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: 'password'.tr,
                obscureText: _isPasswordHidden,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              CustomText(
                text: 'passwordConfirmation'.tr,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _passwordConfirmationController,
                hintText: 'passwordConfirmation'.tr,
                obscureText: _isPasswordConfirmationHidden,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordConfirmationHidden =
                          !_isPasswordConfirmationHidden;
                    });
                  },
                  icon: Icon(
                    _isPasswordConfirmationHidden
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(() {
                if (_authController.isChangePasswordLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  radius: 4,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!AppUtil.isPasswordValidate(_passwordController.text,
                          _passwordConfirmationController.text)) {
                        AppUtil.errorToast(context, "invalidPassword".tr);
                        return;
                      }
                      if (!AppUtil.isPasswordLengthValidate(
                          _passwordController.text)) {
                        AppUtil.errorToast(context, "invalidPasswordLength".tr);
                        return;
                      }
                      final isSuccess = await _authController.changePassword(
                        email: widget.email,
                        password: _passwordController.text,
                        passwordConfirmation:
                            _passwordConfirmationController.text,
                        context: context,
                      );
                      if (isSuccess) {
                        getStorage.remove('token');
                        getStorage.remove('customerId');
                        Get.offAll(() => const LoginScreen());
                        if (context.mounted) {
                          AppUtil.successToast(
                              context, "passwordChangeSuccessfully".tr);
                        }
                      }
                    }
                  },
                  title: 'change'.tr,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
