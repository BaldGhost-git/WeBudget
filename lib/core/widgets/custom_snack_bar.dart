import 'package:flutter/material.dart';

enum CustomSnackBarMode { error, success }

class CustomSnackBar {
  static show(
    BuildContext context,
    CustomSnackBarMode mode,
    String content, {
    int durationInSeconds = 2,
    SnackBarAction? action,
  }) {
    final backgroundColor = switch (mode) {
      CustomSnackBarMode.error => Colors.red[400],
      CustomSnackBarMode.success => Colors.green[300],
    };
    final snackBar = SnackBar(
      action: action,
      duration: Duration(seconds: durationInSeconds),
      backgroundColor: backgroundColor,
      content: Text(
        content,
        maxLines: 1,
        style: TextStyle(overflow: TextOverflow.ellipsis),
      ),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
