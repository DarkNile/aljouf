import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:aljouf/home/view/home_page.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authController = Get.put(AuthController());
  final _profileController = Get.put(ProfileController());
  final _checkoutController = Get.put(CheckoutController());
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
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
                      text: 'createAccount'.tr,
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'firstName'.tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        CustomTextField(
                          controller: _firstNameController,
                          hintText: 'firstName'.tr,
                          textInputType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'lastName'.tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        CustomTextField(
                          controller: _lastNameController,
                          hintText: 'lastName'.tr,
                          textInputType: TextInputType.name,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              CustomText(
                text: 'emailAddress'.tr,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: 'emailAddress'.tr,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.alternate_email),
              ),
              const SizedBox(
                height: 26,
              ),
              CustomText(
                text: 'phoneNumber'.tr,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextField(
                controller: _phoneNumberController,
                hintText: 'phoneNumber'.tr,
                maxLength: 9,
                textInputType: TextInputType.phone,
                prefixIcon: AppUtil.rtlDirection(context)
                    ? null
                    : const Directionality(
                        textDirection: TextDirection.ltr,
                        child: CountryCodePicker(
                          enabled: false,
                          initialSelection: 'SA',
                        ),
                      ),
                suffixIcon: AppUtil.rtlDirection(context)
                    ? const Directionality(
                        textDirection: TextDirection.ltr,
                        child: CountryCodePicker(
                          enabled: false,
                          initialSelection: 'SA',
                        ),
                      )
                    : null,
              ),
              const SizedBox(
                height: 26,
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
                if (_authController.isRegisterLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  radius: 4,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!AppUtil.isEmailValidate(_emailController.text)) {
                        AppUtil.errorToast(context, "invalidEmail".tr);
                        return;
                      }
                      if (!AppUtil.isPhoneValidate(
                          _phoneNumberController.text)) {
                        AppUtil.errorToast(context, "invalidPhone".tr);
                        return;
                      }
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
                      final user = await _authController.register(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        telephone: _phoneNumberController.text,
                        password: _passwordController.text,
                        confirm: _passwordConfirmationController.text,
                        context: context,
                      );
                      if (user != null) {
                        _profileController.getAccount();
                        _checkoutController.getCartItems();
                        Get.offAll(() => const HomePage());
                      }
                    }
                  },
                  title: 'signUp'.tr,
                );
              }),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
