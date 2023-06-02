import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/utils/app_util.dart';

class CustomInput extends StatelessWidget {
  final String? hint, lable;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function()? onTap;
  final Function(String v)? onChange;
  final bool obscureText, readOnly, autofocus, validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines, maxLength;
  final double radius;
  final TextAlign? textAlign;
  final Color? borderColor, fillColor;

  const CustomInput(
      {Key? key,
      required this.controller,
      this.hint,
      this.lable,
      required this.textInputType,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.onChange,
      this.maxLines,
      this.textAlign,
      this.readOnly = false,
      this.autofocus = false,
      this.radius = 15.0,
      this.maxLength,
      this.validation = true,
      this.borderColor,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      // maxLength: maxLength,
      keyboardType: textInputType,
      textAlign: textAlign != null
          ? textAlign!
          : AppUtil.rtlDirection(context)
              ? TextAlign.right
              : TextAlign.left,
      onChanged: onChange,
      validator: validation
          ? (v) {
              if (v!.isEmpty) {
                return "fieldRequired".tr;
              }
              return null;
            }
          : null,
      autofocus: autofocus,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hint,
        counterStyle: const TextStyle(fontSize: 0, height: 0),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: suffixIcon,
        ),
        labelText: lable,

        // labelStyle: TextStyle(color: AppUI.secondColor),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        suffixIconConstraints: const BoxConstraints(minWidth: 63),
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: height * 0.021,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor ?? Colors.grey)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor ?? Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            borderSide:
                BorderSide(color: borderColor ?? Colors.grey, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor ?? Colors.black)),
      ),
    );
  }
}
