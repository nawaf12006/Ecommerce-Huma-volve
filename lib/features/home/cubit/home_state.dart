// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.categoryList = const [],
    this.productList = const [],
    this.categoryStatus = RequestStatusEnum.loading,
    this.productStatus = RequestStatusEnum.loading,
    this.categoryErrorMessage,
    this.productErrorMessage,
    this.selectedCategory = 0,
  });

  final List<CategoryModel> categoryList;
  final List<ProductModel> productList;

  final RequestStatusEnum categoryStatus;
  final RequestStatusEnum productStatus;
  final String? categoryErrorMessage;
  final String? productErrorMessage;

  final int selectedCategory;

  HomeState copyWith({
    List<CategoryModel>? categoryList,
    List<ProductModel>? productList,
    RequestStatusEnum? categoryStatus,
    RequestStatusEnum? productStatus,
    String? categoryErrorMessage,
    String? productErrorMessage,
    int? selectedCategory,
  }) {
    return HomeState(
      categoryList: categoryList ?? this.categoryList,
      productList: productList ?? this.productList,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      productStatus: productStatus ?? this.productStatus,
      categoryErrorMessage: categoryErrorMessage ?? this.categoryErrorMessage,
      productErrorMessage: productErrorMessage ?? this.productErrorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
    categoryList,
    productList,
    categoryStatus,
    productStatus,
    categoryErrorMessage,
    productErrorMessage,
    selectedCategory,
  ];
}
