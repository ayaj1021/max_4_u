import 'dart:developer';

import 'package:flutter/material.dart';
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

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
        //  _message = response['data']['error_data']['mobile_number'];

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }
}
