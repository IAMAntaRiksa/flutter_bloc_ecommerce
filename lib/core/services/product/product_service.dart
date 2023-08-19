// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_app_ecommerce/core/data/base_api.dart';
import 'package:flutter_app_ecommerce/core/models/api/api_response.dart';
import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';
import 'package:flutter_app_ecommerce/core/models/product/product_model.dart';

class ProductService {
  BaseAPI api;

  ProductService(this.api);

  Future<ApiResultList<ProductModel>> getRestaurants() async {
    APIResponse response = await api.get(api.endpoint.getProducts);
    return ApiResultList<ProductModel>.fromJson(
      response.data,
      (i) => i.map((e) => ProductModel.fromJson(e)).toList(),
      "data",
    );
  }
}
