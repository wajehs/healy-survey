import 'package:flutter/material.dart';

class SnackbarUtility {
  // to publish  Snack message
  static void publishMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
