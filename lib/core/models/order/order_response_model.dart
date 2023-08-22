// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';

class OrderModel extends Serializable {
  final String? token;
  final String? url;

  OrderModel({
    this.token,
    this.url,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      token: json['token'] ?? "",
      url: json['redirect_url'] ?? "",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'redirect_url': url,
    };
  }
}
