import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class SetupPricesProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

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
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];

        _message = response['data']['message'];
        state = ViewState.Success;

        notifyListeners();
      } else {
        _message = response['data']['message'];
       // _message = response['data']['error_data']['vending_code'];
        _status = response['data']['status'];
        state = ViewState.Error;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      state = ViewState.Error;
      notifyListeners();
    }
  }
}
