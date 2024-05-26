// import 'package:dio/dio.dart';

// class CustomDioErrorHandler {
//   static void handle(DioException error) {
//     if (error.response != null) {
//       print('Server Error: ${error.response?.statusCode} ${error.response?.data}');
//     } else {
//       print('Client Error: ${error.message}');
//     }

//     switch (error.type) {
//       case DioExceptionType.cancel:
//         print('Request to API server was cancelled');
//         break;
//       case DioExceptionType.connectionTimeout:
//         print('Connection timeout with API server');
//         break;
//       case DioExceptionType.unknown:
//         print('Connection to API server failed due to internet connection');
//         break;
//       case DioExceptionType.receiveTimeout:
//         print('Receive timeout in connection with API server');
//         break;
//       case DioExceptionType.badResponse:
//         print('Received invalid status code: ${error.response?.statusCode}');
//         break;
//       case DioExceptionType.sendTimeout:
//         print('Send timeout in connection with API server');
//         break;
//     }
//   }
// }