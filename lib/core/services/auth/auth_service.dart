import 'package:flutter_app_ecommerce/core/data/base_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/core/models/api/api_response.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_request.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_response.dart';

class AuthServices {
  BaseAPI api;
  AuthServices(
    this.api,
  );

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    APIResponse response = await api.post(
      api.endpoint.authLogin,
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.data!));
    } else {
      return const Left('Password Dan Email Salah!, Silakan Coba login ulang');
    }
  }

  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    APIResponse response = await api.post(
      api.endpoint.authRegiser,
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.data!));
    } else {
      return const Left('Register Gagal Perikasa Koneksi!');
    }
  }
}
