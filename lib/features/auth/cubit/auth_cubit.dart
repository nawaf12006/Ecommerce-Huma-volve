import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/enums/request_status_enum.dart';
import 'package:ecommerce_app_huma_volve/core/error/dio_error_handler.dart';
import 'package:ecommerce_app_huma_volve/features/auth/services/auth_services.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sigup_req_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authServices) : super(AuthState());

  final AuthServices authServices;

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: RequestStatusEnum.loading));

    try {
      await authServices.login(email: email, password: password);
      emit(state.copyWith(status: RequestStatusEnum.loaded));
    } on DioException catch (e) {
      emit(state.copyWith(status: RequestStatusEnum.error));
      DioErrorHandler.handle(e);
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    //   emit(state.copyWith(status: RequestStatusEnum.loading));

    //   try {
    //     await loginServices.login(email: email, password: password);
    //     emit(state.copyWith(status: RequestStatusEnum.loaded));
    //   } on DioException catch (e) {
    //     emit(state.copyWith(status: RequestStatusEnum.loaded));
    //     DioErrorHandler.handle(e);
    //   }

    try {
      emit(state.copyWith(status: RequestStatusEnum.loading));
      await authServices.signup(
        SigupReqModel(name: name, email: email, password: password),
      );
      emit(state.copyWith(status: RequestStatusEnum.loaded));
    } on DioException catch (e) {
      emit(state.copyWith(status: RequestStatusEnum.error));
      DioErrorHandler.handle(e);
    }
  }
}
