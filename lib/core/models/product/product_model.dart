import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';
import 'package:flutter_app_ecommerce/core/models/attribute/attribute_model.dart';

class ProductModel extends Serializable {
  final int id;
  final AttributeDetailModel? attributes;

  ProductModel({
    required this.id,
    required this.attributes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      attributes: json['attributes'] != null
          ? AttributeDetailModel.fromJson(json['attributes'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'attributes': attributes?.toJson(),
    };
  }
}
