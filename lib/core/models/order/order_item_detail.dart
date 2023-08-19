// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';

class OrderItemDetail extends Serializable {
  final int id;
  final String productName;
  final String price;
  final int qty;

  OrderItemDetail({
    required this.id,
    required this.productName,
    required this.price,
    required this.qty,
  });

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) {
    return OrderItemDetail(
      id: json['id'],
      productName: json['productName'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'qty': qty,
    };
  }
}
