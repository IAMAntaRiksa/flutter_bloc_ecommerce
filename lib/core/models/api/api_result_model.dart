class ApiResult<T extends Serializable> {
  final RError? status;
  final bool? error;
  final T? data;

  ApiResult({
    this.status,
    this.error,
    this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic>? json,
      Function(Map<String, dynamic>) create, String field) {
    return ApiResult<T>(
      status: json?['error'] != null ? RError.fromJson(json?['error']) : null,
      error: json?['message'] ?? false,
      data: json?[field] != null && json?[field] is Map
          ? create(json?[field] ?? {})
          : create({}),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": error,
        "error": status,
        "data": data?.toJson(),
      };
}

class ApiResultList<T extends Serializable> {
  final RError? status;
  final bool? error;
  final List<T>? data;

  ApiResultList({
    this.status,
    this.error,
    this.data,
  });

  factory ApiResultList.fromJson(
      Map<String, dynamic>? json, Function(List<dynamic>) build, String field) {
    return ApiResultList<T>(
      status: json?['error'] != null ? RError.fromJson(json?['error']) : null,
      error: json?['message'] ?? false,
      data: json?[field] != null && json?[field] is List
          ? build(json?[field])
          : build([]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": error,
        "error": status,
        "data": data?.toList(),
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}

class RError {
  final String? data;
  final int status;
  final String message;

  RError({
    this.data,
    required this.status,
    required this.message,
  });

  factory RError.fromJson(Map<String, dynamic> json) {
    return RError(
      data: json['data'],
      message: json['message'],
      status: json['status'],
    );
  }
}
