import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class BuyAirtimeProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<void> buyAirtime(
      {required String amount,
      required String productCode,
      required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final id = await SecureStorage().getEncryptedID();

    final body = {
      "request_type": "user",
      "action": "buy_airtime",
      "product_code": productCode,
      "user_id": id,
      "number": phoneNumber,
      "amount": amount,
    };
    debugPrint('$body');

    // final encryptedId = await SecureStorage().getUserEncryptedId();

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );
    final data = response.data;

    _status = data['data']['status'];
    _message = data['data']['message'];

    debugPrint('$_status');
    debugPrint('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;
        _message = data['data']['message'];
        _message = data['error_data']['number'];
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }
}
