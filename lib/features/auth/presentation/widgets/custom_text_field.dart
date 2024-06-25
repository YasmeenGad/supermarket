import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textFieldModel,
  });
  final CustomTextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${textFieldModel.text}",
            style: AppStyles.styleSemiBold16.copyWith(color: secondaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                hintText: textFieldModel.hintText,
                hintStyle: TextStyle(color: secondaryColor),
                suffixIcon: textFieldModel.suffixIcon != null
                    ? textFieldModel.suffixIcon
                    : SizedBox()),
          )
        ],
      ),
    );
  }
}
