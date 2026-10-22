import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToastification {
  AppToastification._();

  static ToastificationItem coustomToastificationWidget({
    required String title,
    String? description,
    required ToastificationType type,
  }) {
    toastification.dismissAll();

    return toastification.show(
      title: Text(title),
      description: description == null ? null : Text(description),
      autoCloseDuration: const Duration(seconds: 3),
      type: type,
    );
  }
}
