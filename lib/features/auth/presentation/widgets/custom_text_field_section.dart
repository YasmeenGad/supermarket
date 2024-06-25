import 'package:flutter/material.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';

class CustomTextFieldSection extends StatelessWidget {
  const CustomTextFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            textFieldModel:
                CustomTextFieldModel(text: 'Username', hintText: 'username'),
          ),
          CustomTextField(
            textFieldModel: CustomTextFieldModel(
                text: 'Email',
                hintText: 'email',
                suffixIcon: Image.asset(Assets.imagesVector)),
          ),
          const CustomTextField(
            textFieldModel: CustomTextFieldModel(
                text: 'Email',
                hintText: 'email',
                suffixIcon: Icon(Icons.visibility_off)),
          ),
          
      ],
    );
  }
}