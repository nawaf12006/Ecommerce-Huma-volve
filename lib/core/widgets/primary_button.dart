import 'package:ecommerce_app_huma_volve/core/enums/request_status_enum.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  RequestStatusEnum status;
  PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.status = RequestStatusEnum.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF3F4145)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
        child: status == RequestStatusEnum.loading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Color(0xFFFFF1A8),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}
