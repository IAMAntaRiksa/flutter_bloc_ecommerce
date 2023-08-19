import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

var _logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(
        "--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}");
    _logger.d("Headers:");
    options.headers.forEach((k, v) => _logger.d('$k: $v'));
    _logger.d("queryParameters:");
    options.queryParameters.forEach((k, v) => _logger.d('$k: $v'));
    if (options.data != null) {
      _logger.d("Body: ${options..data}");
    }
    _logger.d("--> END ${options.method.toUpperCase()}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
        "<-- ${response.statusCode} ${response.requestOptions.baseUrl}${response.requestOptions.path}");
    _logger.i("Headers:");
    response.headers.forEach((k, v) => _logger.i('$k: $v'));
    _logger.i("Response: ${response.data}");
    _logger.i("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
        "<-- ${err.message} ${(err.response?.requestOptions != null ? ('${err.response?.requestOptions.baseUrl ?? ''}' '${err.response?.requestOptions.path ?? ''}') : 'URL')}");
    _logger.e("${err.response != null ? err.response?.data : 'Unknown Error'}");
    _logger.e("<-- End error");
    return super.onError(err, handler);
  }
}
