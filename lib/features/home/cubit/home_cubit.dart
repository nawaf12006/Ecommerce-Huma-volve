import 'package:ecommerce_app_huma_volve/core/enums/request_status_enum.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(HomeState()) {
    initHome();
  }

  final HomeService homeService;

  Future<void> initHome() async {
    await getCategories();
    await getProducts(0);
  }

  Future<void> getCategories() async {
    try {
      final categories = await homeService.getCategories();
      emit(
        state.copyWith(
          categoryList: categories,
          categoryStatus: RequestStatusEnum.loaded,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          categoryErrorMessage: e.toString(),
          categoryStatus: RequestStatusEnum.error,
        ),
      );
    }
  }

  Future<void> getProducts(int selectedCategory) async {
    emit(state.copyWith(productStatus: RequestStatusEnum.loading));
    try {
      final products = await homeService.getProduct(
        state.categoryList[selectedCategory].id,
      );
      emit(
        state.copyWith(
          productList: products,
          productStatus: RequestStatusEnum.loaded,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          categoryErrorMessage: e.toString(),
          productStatus: RequestStatusEnum.error,
        ),
      );
    }
  }

  void updateSelectedCategory(int selectedCategory) {
    emit(state.copyWith(selectedCategory: selectedCategory));

    getProducts(selectedCategory);
  }
}
