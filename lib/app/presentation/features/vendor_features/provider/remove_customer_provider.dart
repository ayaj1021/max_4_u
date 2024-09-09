import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/domain/exception_handler.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class RemoveCustomerProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<void> removeCustomer({
    required String userId,
  }) async {
    state = ViewState.Busy;
    _message = 'Removing your customer...';
    notifyListeners();

    final body = {
      "request_type": "reseller",
      "action": "remove_client",
      "beneficiary_id": userId,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;

    _status = data['status'];
    _message = data['message'];

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['status'];
        state = ViewState.Error;
        _message = data['message'];
        //  _message = response['data']['error_data']['mobile_number'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // notifyListeners();
    }
  }
}
