import 'package:ecommerce_app_huma_volve/core/constants/auth_api_config.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';

class HomeService {
  Future<List<CategoryModel>> getCategories() async {
    final response = await ApiClient.createDio().get(ApiConfig.categories);

    return (response.data as List<dynamic>)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  Future<List<ProductModel>> getProduct(int id) async {
    final response = await ApiClient.createDio().get(
      '${ApiConfig.categories}/$id/${ApiConfig.products}',
    );
    return (response.data as List<dynamic>)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
