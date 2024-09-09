import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/constants.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';

class SetupPricesProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;
  final _dio = Dio();

  Future<void> setupPrices({
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
    debugPrint('$body');

    final id = await SecureStorage().getEncryptedID();

    final response = await _dio.post(AppConstants.baseUrl,
        data: body,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Site-From': 'postman',
          'User-Key': id
        }));

    // ApiService().servicePostRequest(
    //   data: body,
    // );
    final data = response.data['data'];
    _status = data['data']['status'];

    debugPrint('$response');
    debugPrint('$_status');

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];

        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        //}
        return data;
      } else {
        _status = data['data']['status'];
        _message = data['data']['message'];
        // _message = response['data']['error_data']['vending_code'];
        state = ViewState.Error;
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }
}
