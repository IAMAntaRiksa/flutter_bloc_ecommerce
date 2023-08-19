// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_app_ecommerce/core/models/api/api_result_model.dart';

class RegisterRequestModel extends Serializable {
  final String name;
  final String password;
  final String email;
  final String username;

  RegisterRequestModel({
    required this.name,
    required this.password,
    required this.email,
    required this.username,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      name: json['name'],
      password: json['password'],
      email: json['email'],
      username: json['username'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'username': username,
    };
  }
}

class LoginRequestModel extends Serializable {
  final String email;
  final String password;
  LoginRequestModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      password: json['password'],
      email: json['identifier'],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'identifier': email,
      'password': password,
    };
  }
}
