// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_item_detail.dart';

class OrderRequestModel extends Serializable {
  final Data data;

  OrderRequestModel({
    required this.data,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Data extends Serializable {
  final List<OrderItemDetail>? items;
  final int price;
  final String address;
  final String courier;
  final int cost;
  final String statusOrder;

  Data({
    this.items,
    required this.price,
    required this.address,
    required this.courier,
    required this.cost,
    required this.statusOrder,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      price: json['totalPrice'],
      address: json['deliveryAddress'],
      courier: json['courierName'],
      cost: json['shippingCost'],
      statusOrder: json['statusOrder'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'totalPrice': price,
      'deliveryAddress': address,
      'courierName': courier,
      'shippingCost': cost,
      'statusOrder': statusOrder,
    };
  }
}
