import 'package:flutter/material.dart';

class CustomTextFieldModel {
  final text;
  final hintText;
  final Widget? suffixIcon;
  final bool isPassword;

  const CustomTextFieldModel(
      {required this.text,
      required this.hintText,
      this.suffixIcon,
      this.isPassword = false});
}
