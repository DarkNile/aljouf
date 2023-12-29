import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.enabled = true,
    this.value,
  });

  final List items;
  final ValueChanged onChanged;
  final String hintText;
  final bool enabled;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      validator: (v) {
        if (v == null) {
          return 'fieldRequired'.tr;
        }
        return null;
      },
      iconEnabledColor: black,
      iconDisabledColor: black,
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: CustomText(
                text: AppUtil.rtlDirection(context) ? e.nameAr : e.name,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
          .toList(),
      onChanged: enabled ? onChanged : null,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      decoration: InputDecoration(
        enabled: enabled,
        counterStyle: const TextStyle(fontSize: 0, height: 0),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
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
            borderSide: BorderSide(color: black, width: 1)),
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
