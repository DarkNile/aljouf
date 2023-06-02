import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/utils/app_util.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.onFieldSubmitted,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.textAlign,
    this.readOnly = false,
    this.autofocus = false,
    this.validator = true,
    this.maxLength,
    this.initialValue,
    this.minLines,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? hintText;
  final Function()? onTap;
  final Function(String v)? onChanged;
  final Function(String v)? onFieldSubmitted;
  final bool obscureText, readOnly, autofocus, validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final int? maxLength;
  final String? initialValue;
  final int? minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      initialValue: initialValue,
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: textInputType,
      textAlign: textAlign != null
          ? textAlign!
          : AppUtil.rtlDirection(context)
              ? TextAlign.right
              : TextAlign.left,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator
          ? (v) {
              if (v!.isEmpty) {
                return 'fieldRequired'.tr;
              }
              return null;
            }
          : null,
      autofocus: autofocus,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        counterStyle: const TextStyle(fontSize: 0, height: 0),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.grey, width: 1)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.grey, width: 1)),
        disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.grey, width: 1)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.black, width: 1)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: vermillion, width: 1)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: vermillion, width: 1)),
      ),
    );
  }
}
