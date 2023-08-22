// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/data/base_api.dart';
import 'package:flutter_app_ecommerce/core/models/api/api_response.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_request_model.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_response_model.dart';
import 'package:flutter_app_ecommerce/core/utils/token/token_utils.dart';

class OrderService {
  BaseAPI api;

  OrderService(this.api);

  Future<Either<String, OrderModel>> orders(OrderRequestModel model) async {
    final Dio _dio = Dio();
    final token = await setToken.getTokenUser();
    Response response = await _dio.post(
      api.endpoint.diOrders,
      data: model.toJson(),
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    debugPrint("DebugData: ${model.toJson()}");
    if (response.statusCode == 200) {
      return Right(OrderModel.fromJson(response.data!));
    } else {
      return const Left('Gagal Order Perikasa Koneksi!');
    }
  }
}
