import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class FundAccountProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
      data: body,
      // message: _message,
    );
    final data = response.data;
    _status = data['status'];
    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['status'];

        _message = data['message'];
        state = ViewState.Success;
        paymentUrl = data['response_data']['payment_link'];
        token = data['response_data']['token'];
        log('this is payment url $paymentUrl');

        notifyListeners();
      } else {
        _message = data['message'];
        _status = data['status'];
        state = ViewState.Error;
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // state = ViewState.Error;
      // notifyListeners();
    }
  }

  Future<void> verifyPayment(
      {required String paymentToken, required BuildContext context}) async {
    _isLoading = true;

    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "verify_transaction",
      "token": paymentToken,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;
    _status = data['status'];
    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['status'];
        //  displayPaymentTransactionStatus(context, response['data']['message']);

        _message = data['message'];
        _isLoading = false;
        paymentUrl = data['response_data']['payment_link'];
        log('this is payment url $paymentUrl');

        notifyListeners();
        return data;
      } else {
        _message = data['message'];
        _status = data['status'];
        _isLoading = false;
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // state = ViewState.Error;
      // notifyListeners();
    }
  }
}
