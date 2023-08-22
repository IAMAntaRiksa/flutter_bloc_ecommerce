// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_item_detail.dart';

class OrderRequestModel extends Serializable {
  final Data data;

  OrderRequestModel({
    required this.data,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      data: Data.fromJson(json['data']),
    );
  }

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
      items: json['items'] != null
          ? List<OrderItemDetail>.from(
              json['items'].map((x) => OrderItemDetail.fromJson(x)))
          : [],
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
      'items': items?.map((x) => x.toJson()).toList(),
      'totalPrice': price,
      'deliveryAddress': address,
      'courierName': courier,
      'shippingCost': cost,
      'statusOrder': statusOrder,
    };
  }

  Data copyWith({
    List<OrderItemDetail>? items,
    int? price,
    String? address,
    String? courier,
    int? cost,
    String? statusOrder,
  }) {
    return Data(
      items: items ?? this.items,
      price: price ?? this.price,
      address: address ?? this.address,
      courier: courier ?? this.courier,
      cost: cost ?? this.cost,
      statusOrder: statusOrder ?? this.statusOrder,
    );
  }
}
