import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';

void toastSuccess(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: successColor,
    textColor: lightText,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

void toastError(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: dangerColor,
    textColor: lightText,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

void errorSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: lightTextStyle.copyWith(
        fontWeight: medium,
      ),
    ),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: dangerColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

void successSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: lightTextStyle.copyWith(
        fontWeight: medium,
      ),
    ),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: successColor,
    duration: const Duration(seconds: 3),
  ).show(context);
}
