// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';

class AuthResponseModel extends Serializable {
  final String jwt;
  final UserModel? user;
  AuthResponseModel({
    required this.jwt,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      jwt: json['jwt'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'jwt': jwt,
      'user': user?.toJson(),
    };
  }
}

class UserModel extends Serializable {
  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confrimed;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confrimed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      provider: json['provider'],
      confrimed: json["confirmed"],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confrimed,
    };
  }
}
