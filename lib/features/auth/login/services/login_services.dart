// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app_huma_volve/core/constants/auth_api_config.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';

class LoginServices {
  LoginServices();

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.createDio().post(
      AuthApiConfig.loginEndPoint,
      data: {"email": email, "password": password},
    );
    final tokens = response.data as Map<String, dynamic>;
    final modelData = LoginModel.fromJson(tokens);

    return modelData;
  }
}
