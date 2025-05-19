import 'package:flutter/material.dart';

import '../../utils/color_palette.dart';
import '../../utils/font_sizes.dart';

class BuildTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType inputType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final Color fillColor;
  final Color? borderColor;
  final int? borderType;
  final Color hintColor;
  final double? hinttextSize;
  final int? maxLength;
  final bool? filled;
  final Function onChange;

  const BuildTextField({
    super.key,
    required this.hint,
    this.controller,
    this.borderColor,
    this.borderType,
    this.filled,
    required this.inputType,
    this.hinttextSize,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.fillColor = kWhiteColor,
    this.hintColor = kGrey1,
    this.maxLength,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder? inputBorder;

    switch (borderType) {
      case 0:
        inputBorder = InputBorder.none;
        break;
      case 1:
        inputBorder = OutlineInputBorder(
          borderSide: BorderSide(color: kGrey3, width: 2.0),
        );
        break;
      case 2:
        inputBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? kBlackColor),
        );
        break;
      default:
        inputBorder = InputBorder.none;
    }

    return TextFormField(
      onChanged: (value) {
        onChange(value);
      },
      validator: (val) => val!.isEmpty ? 'This field is required' : null,
      keyboardType: inputType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: inputType == TextInputType.multiline ? 3 : 1,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        border: inputBorder,
        counterText: '',
        fillColor: fillColor,
        filled: filled,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: hinttextSize,
          fontWeight: FontWeight.w300,
          color: hintColor,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(
          fontSize: textMedium,
          fontWeight: FontWeight.normal,
          color: kRed,
        ),
      ),
      cursorColor: kBlackColor,
      style: const TextStyle(
        fontSize: textMedium,
        fontWeight: FontWeight.normal,
        color: kBlackColor,
      ),
    );
  }
}
