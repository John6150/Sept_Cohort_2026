import 'package:dio/dio.dart';

class GetDio {
  final dio = Dio();

  Dio dio_() {
    dio.options = BaseOptions(
      baseUrl: 'https://dummyjson.com',
      // headers: {'Authorization': 'Bearer token'},
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(milliseconds: 5),
      receiveTimeout: Duration(milliseconds: 1),
    );

    String? errorMessage;
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response, handler) {
          final Response res = Response(
            requestOptions: RequestOptions(),
            data: response.data,
            // message: response.statusMessage ?? 'success',
            // error: eMessage(statusCode: response.statusCode ?? 400),
            statusCode: response.statusCode ?? 400,
          );
          handler.next(response);
        },
        onRequest: (options, handler) {
          String? token = '';
          if (token != null) {
            options.headers = {'Authorization': 'Bearer $token'};
          }
          handler.next(options);
        },
        onError: (error, handler) {
          switch (error.type) {
            case DioExceptionType.receiveTimeout:
              errorMessage = 'Try again';
            case DioExceptionType.sendTimeout:
              errorMessage = 'Bad network';
            case DioExceptionType.connectionTimeout:
              errorMessage = 'Could not connect, check your network';
            case DioExceptionType.connectionError:
              errorMessage = 'Connection error, try again';
            default:
              errorMessage = 'Unknown error';
          }
          return handler.next(
            DioException(
              requestOptions: error.requestOptions,
              type: error.type,
              error: errorMessage,
            ),
          );
        },
      ),
    );
    return dio;
  }
}

class ResponseModel {
  final String message;
  final String? error;
  final Map<String, dynamic> data;
  final int statusCode;
  ResponseModel({
    required this.data,
    required this.message,
    required this.statusCode,
    this.error,
  });
}

String eMessage({required int statusCode}) {
  switch (statusCode) {
    case 400 || 404 || 402:
      return 'Invalid inout, try again';
    case 500:
      return 'Successful request';
    default:
      return '';
  }
}
