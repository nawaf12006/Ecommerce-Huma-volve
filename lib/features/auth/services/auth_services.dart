import 'package:ecommerce_app_huma_volve/core/constants/auth_api_config.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sigup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/user_model.dart';

class AuthServices {
  Future<UserModel> signup(SigupReqModel sigupReqModel) async {
    final response = await ApiClient.createDio().post(
      ApiConfig.signupEndPoint,
      data: {
        "email": sigupReqModel.email,
        "name": sigupReqModel.name,
        "password": sigupReqModel.password,
        "avatar": "https://i.pinimg.com/originals/16/96/b4/1696b49b4a57382d4ee3862dc40ae3ce.jpg",
      },
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.createDio().post(
      ApiConfig.loginEndPoint,
      data: {"email": email, "password": password},
    );
    final tokens = response.data as Map<String, dynamic>;
    final modelData = LoginModel.fromJson(tokens);

    return modelData;
  }
}
