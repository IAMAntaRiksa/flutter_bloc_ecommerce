// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class APIResponse {
//   final int statusCode;
//   final String message;
//   final Map<String, dynamic>? data;

//   APIResponse({
//     required this.statusCode,
//     required this.message,
//     this.data,
//   });

//   factory APIResponse.fromJson(Map<String, dynamic> json) {
//     return APIResponse(
//       statusCode: json['statusCode'],
//       message: json['message'],
//       data: json['data'],
//     );
//   }
class APIResponse {
  final int statusCode;
  final bool success;
  final Map<String, dynamic>? data;

  APIResponse({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      statusCode: json['statusCode'],
      success: true,
      data: json['data'],
    );
  }

  factory APIResponse.failure(int code, String message) => APIResponse(
        statusCode: code,
        success: false,
        data: null,
      );
}
