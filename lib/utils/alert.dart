import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

class Alert {
  static showToast({required BuildContext context, required String text, required IconData icon}) {
    DelightToastBar(
      autoDismiss: true,
      builder: (context) => ToastCard(
        leading: Icon(icon),
        title: Text(text),
      ),
    ).show(context);
  }

  static showErrorToast({required BuildContext context, required String text}) {
    DelightToastBar(
      autoDismiss: true,
      builder: (context) => ToastCard(
        color: Colors.red,
        leading: const Icon(Icons.error),
        title: Text(text),
      ),
    ).show(context);
  }
}
