import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/constants.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';

class SetupPricesProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;
  final _dio = Dio();

  Future<UpdatedBaseResponse<dynamic>> setupPrices({
    required String category,
    required String productPrice,
    required String serviceName,
    required String logoName,
    required String productName,
    required String productCode,
    required String customerDiscount,
    required String vendorDiscount,
    required String serviceFee,
    required String duration,
    required String vendingCode,
  }) async {
    state = ViewState.Busy;
    _message = 'Setting up prices...';
    notifyListeners();

    try {
      // Get the encrypted user ID

      final storage = await SecureStorage();
      final id = await storage.getUserEncryptedId();

      // Make the API request using Dio

      final body = {
        "request_type": "grand_admin",
        "action": "set_product",
        "product_name": productName,
        "product_code": productCode,
        "service_name": serviceName,
        "category": category,
        "product_price": productPrice,
        "consumer_discount": customerDiscount,
        "vendor_discount": vendorDiscount,
        "service_fee": serviceFee,
        "logo_name": logoName,
        "duration": duration,
        "vending_code": vendingCode
      };

      log('$body');

      //  _dio.options.baseUrl = AppConstants.baseUrl;

      // print('$headers');
      final response = await _dio.post(
        AppConstants.baseUrl,
        data: body,
        options: Options(
          validateStatus: (_) => true,
          // contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Site-From': 'postman',
            'User-Key': id
          },
          contentType: Headers.jsonContentType,
        ),
      );

      print('${response.data}');
      print('${response.statusCode}');

      final data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        _message = data['data']['message'];

        state = ViewState.Success;
        notifyListeners();
        // return data;
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        // Handle non-success status codes
        // final errorData = response.data['data']['error_data'];
        final errorData = response.data['data']['message'];
        _message = errorData ?? 'Unknown error occurred';
        _status = false;

        state = ViewState.Error;
        notifyListeners();

        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      // Handle DioException, check for 401 Unauthorized and other errors
      if (e.response?.statusCode == 401) {
        _message = e.toString();
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
