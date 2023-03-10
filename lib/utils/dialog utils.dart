import 'package:flutter/material.dart';

class DialogUtils {
  static void showProgressDialog(BuildContext context, String message,
      {bool isDismissible = true}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 12,
              ),
              Text(message),
            ],
          ),
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static showMessage(
      BuildContext context,
      String message, {
        bool isDismissible = true,
        VoidCallback? posAction,
        VoidCallback? negAction,
        String? posActionTitle,
        String? negActionTitle,
        String? posMessage,
        String? negMessage,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        List<Widget> actions = [];
        if (posActionTitle != null) {
          actions.add(
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (posAction != null) {
                    posAction();
                  }
                },
                child: Text(posActionTitle)),
          );
        }
        if (negActionTitle != null) {
          actions.add(
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (negAction != null) {
                    negAction();
                  }
                },
                child: Text(negActionTitle)),
          );
        }
        return AlertDialog(
          content: Text(message),
          actions: actions,
        );
      },
      barrierDismissible: isDismissible,
    );
  }
}