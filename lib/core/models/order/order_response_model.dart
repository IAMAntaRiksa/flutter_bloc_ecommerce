// ignore_for_file: public_member_api_docs, sort_constructors_first

class OrderModel {
  final String? token;
  final String? url;
  OrderModel({
    this.token,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'url': url,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      token: map['token'] ?? "",
      url: map['redirect_url'] ?? "",
    );
  }
}
