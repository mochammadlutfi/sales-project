import 'package:dio/dio.dart';
import 'cache_manager.dart';


ApiClient apiClient = ApiClient();

class ApiClient with CacheManager{
  static final ApiClient _apiClient = ApiClient._i();
  final Dio _dio = Dio();

  ApiClient._i() {
    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }

  factory ApiClient() {
    return _apiClient;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> getSecure({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = getToken();
    Options options = Options(headers: {
      "Accept" : "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> postSecure({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = getToken();
    Options options = Options(headers: {
      "Accept" : "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    //Sending FormData:
    // FormData formData = FormData.fromMap({"name": ""});

    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    // FormData formData = FormData.fromMap({"name": ""});

    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    //
    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var token = getToken();
    Options options = Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var result = await _dio.delete(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    // Log.loga(title, "handleError:: error >> $error");

    if (error is DioError) {
      // Log.loga(
      //     title, '************************ DioError ************************');

      DioError dioError = error;
      // Log.loga(title, 'dioError:: $dioError');
      if (dioError.response != null) {
        // Log.loga(
            // title, "dioError:: response >> " + dioError.response.toString());
      }

    } else {
      errorDescription = "Unexpected error occured";
    }
    // Log.loga(title, "handleError:: errorDescription >> $errorDescription");
    return errorDescription;
  }

  getFormattedError() {
    return {'error': 'Error'};
  }

  getNetworkError() {
    return "No Internet Connection.";
  }
}