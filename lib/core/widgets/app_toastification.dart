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
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      description: description == null
          ? null
          : Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
      autoCloseDuration: const Duration(seconds: 4),
      type: type,
    );
  }
}
