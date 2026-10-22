import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constants/auth_api_config.dart';
import 'package:ecommerce_app_huma_volve/core/network/interceptors/logging_interceptor.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio(BaseOptions(baseUrl: AuthApiConfig.baseUrl));
    dio.interceptors.add(LoggingInterceptor());

    return dio;
  }
}
