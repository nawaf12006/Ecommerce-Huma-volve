// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.status = RequestStatusEnum.initial, this.errorMessage});
  final RequestStatusEnum status;
  final String? errorMessage;

  AuthState copyWith({RequestStatusEnum? status, String? errorMessage}) {
    return AuthState(status: status ?? this.status, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
