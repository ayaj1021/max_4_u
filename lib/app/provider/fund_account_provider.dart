import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';
import 'package:max_4_u/app/utils/display_payment_transaction_title.dart';

class FundAccountProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;
  String paymentUrl = '';
  String token = '';

  Future<void> initializePayment({required String amount}) async {
    state = ViewState.Busy;
    _message = 'Funding account...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "initialize_payment",
      "amount": amount,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];

        _message = response['data']['message'];
        state = ViewState.Success;
        paymentUrl = response['data']['response_data']['payment_link'];
        token = response['data']['response_data']['token'];
        log('this is payment url $paymentUrl');

        notifyListeners();
      } else {
        _message = response['data']['message'];
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

  Future<void> verifyPayment(
      {required String paymentToken, required BuildContext context}) async {
    state = ViewState.Busy;
    _message = 'Funding account...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "verify_transaction",
      "token": paymentToken,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];
        displayPaymentTransactionStatus(context, response['data']['message']);

        _message = response['data']['message'];
        state = ViewState.Success;
        paymentUrl = response['data']['response_data']['payment_link'];
        log('this is payment url $paymentUrl');

        notifyListeners();
      } else {
        _message = response['data']['message'];
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
