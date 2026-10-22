// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  String? accessToken;
  String? refreshToken;

  LoginModel({this.accessToken, this.refreshToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }

  @override
  String toString() =>
      'LoginModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}
