import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomAwesomDialog {
  static void showErrorDialog(BuildContext context, String state) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: state,
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkColor: Colors.red,
      btnOkText: 'Ok',
    ).show();
  }
}
