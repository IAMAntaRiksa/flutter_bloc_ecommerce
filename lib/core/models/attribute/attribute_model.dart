import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';

class AttributeDetailModel extends Serializable {
  final String name;
  final String description;
  final int price;
  final bool? stock;
  final String image;
  final String distributor;
  final int? qty;

  AttributeDetailModel({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.distributor,
    required this.qty,
  });

  factory AttributeDetailModel.fromJson(Map<String, dynamic> json) {
    return AttributeDetailModel(
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] ?? 0,
      stock: json['inStock'] ?? false,
      image: json['image'] ?? "",
      distributor: json['distributor'] ?? "",
      qty: json['qty'] != null ? json['qty'] as int : null,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'inStock': stock,
      'image': image,
      'distributor': distributor,
      'qty': qty,
    };
  }
}
