import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class SaveBeneficiaryProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<void> saveToBeneficiary({
    required String phoneNumber,
    required String beneficiaryName,
  }) async {
    state = ViewState.Busy;
    _message = 'Saving your beneficiary...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "save_beneficiary",
      "mobile_number": phoneNumber,
      "name": beneficiaryName,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );

    _message = response['data']['message'];

    log('$_status');
    log('$response');
    try {
    _status = response['data']['status'];
      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;
        _message = response['data']['message'];

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }
}
