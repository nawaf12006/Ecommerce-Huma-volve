import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/app_toastification.dart';
import 'package:toastification/toastification.dart';

class DioErrorHandler {
  DioErrorHandler._();

  static void handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        _show('Connection timeout', 'Please check your internet');
        break;

      case DioExceptionType.sendTimeout:
        _show('Send timeout', 'Please try again');
        break;

      case DioExceptionType.receiveTimeout:
        _show('Receive timeout', 'Server took too long to respond');
        break;

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        _show('Server error', 'Request failed ($statusCode)');
        break;

      case DioExceptionType.cancel:
        _show('Request cancelled', 'The request was cancelled');
        break;

      case DioExceptionType.connectionError:
        _show('No Internet Connection', 'Please check your connection');
        break;

      default:
        _show('Failed to load data', 'Something went wrong. Please try again');
        break;
    }
  }

  static void _show(String title, String description) {
    AppToastification.coustomToastificationWidget(
      title: title,
      description: description,
      type: ToastificationType.error,
    );
  }
}
