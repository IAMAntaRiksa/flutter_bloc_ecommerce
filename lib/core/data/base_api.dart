// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/data/api.dart';

import 'package:flutter_app_ecommerce/core/data/base_api_impl.dart';
import 'package:flutter_app_ecommerce/core/data/dio_logger.dart';
import 'package:flutter_app_ecommerce/core/models/api/api_response.dart';
import 'package:flutter_app_ecommerce/core/utils/token/token_utils.dart';
import 'package:flutter_app_ecommerce/injector.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;

  final endpoint = locator<Api>();
  BaseAPI({Dio? dio}) {
    _dio = dio ?? Dio();
    _dio?.interceptors.add(Logging());
  }

  @override
  Future<APIResponse> delete(String url,
      {Map<String, dynamic>? param, bool? useToken}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<APIResponse> get(String url,
      {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.get(
        url,
        options: await getHeaders(useToken: useToken),
        queryParameters: param,
      );

      return _parseResponse(result);
    } on DioException catch (e) {
      debugPrint('Error: get');
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('DATA: ${e.response?.data}');
      debugPrint('HEADERS: ${e.response?.headers}');
      return APIResponse.failure(
          e.response?.statusCode ?? 404, e.response!.statusMessage ?? "");
    }
  }

  @override
  Future<APIResponse> post(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.post(
        url,
        options: await getHeaders(useToken: useToken),
        queryParameters: param,
        data: data,
      );
      return _parseResponse(result);
    } on DioException catch (e) {
      debugPrint('Error: get');
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('DATA: ${e.response?.data}');
      debugPrint('HEADERS: ${e.response?.headers}');
      return APIResponse.failure(
          e.response?.statusCode ?? 402, e.response!.statusMessage ?? "");
    }
  }

  @override
  Future<APIResponse> put(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Future<Options> getHeaders({bool? useToken}) async {
    var header = <String, dynamic>{};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json';

    if (useToken == true) {
      header['Authorization'] = 'Bearer <Token>';
    }
    return Options(
      headers: header,
      sendTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    );
  }

  Future<APIResponse> _parseResponse(Response? response) async {
    return APIResponse.fromJson({
      'statusCode': response?.statusCode,
      'data': response?.data,
    });
  }
}
