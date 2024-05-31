import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class BuyDataProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<void> buyData(
      {required String amount,
      required String productCode,
      required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final id = await SecureStorage().getEncryptedID();

    final body = {
      "request_type": "user",
      "action": "buy_data",
      "product_code": productCode,
      "user_id": id,
      "number": phoneNumber,
      "amount": amount,
    };
    log('$body');

   // final encryptedId = await SecureStorage().getUserEncryptedId();

   // log('this is $encryptedId');

    final response = await ApiService.instance.servicePostRequest(
      body: body,
      // message: _message,
    );

    _status = response['data']['status'];
    _message = response['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;
        _message = response['data']['message'];

        // // statusCode: statusCode,

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
         _message = response['data']['error_data']['number'];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }
}
