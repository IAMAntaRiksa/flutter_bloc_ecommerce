import 'dart:convert';

import 'package:flutter_app_ecommerce/core/models/auth/auth_response.dart';
import 'package:flutter_app_ecommerce/core/utils/global/shared_manager_utils.dart';
import 'package:flutter_app_ecommerce/injector.dart';

class TokenUtils {
  final String _token = 'token';

  Future<void> saveTokenUser(AuthResponseModel model) async {
    SharedManagerUtils shared = SharedManagerUtils<String>();
    final result = shared.store(_token, jsonEncode(model.toJson()));
    return result;
  }

  Future<String> getTokenUser() async {
    final shared = SharedManagerUtils<String>();
    final tokens = await shared.read(_token) ?? "";
    final authData = AuthResponseModel.fromJson(jsonDecode(tokens));
    return authData.jwt;
  }

  Future<bool> isLogin() async {
    final shared = SharedManagerUtils<String>();
    final tokens = await shared.read(_token) ?? "";
    return tokens.isNotEmpty;
  }

  Future<void> removeToken() async {
    final shared = SharedManagerUtils<String>();
    shared.clear(_token);
  }
}

final setToken = locator<TokenUtils>();
