import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/vendor/generate_account_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GenerateAccountProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  BankData bankData = BankData();

  Future generateAccount() async {
    state = ViewState.Busy;
    _message = 'Generating account details...';
    notifyListeners();

    final body = {
      "request_type": "reseller",
      "action": "generate_bank_account"
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

        bankData = BankData.fromJson(response['data']['response_data']);
        _message = response['data']['message'];
        state = ViewState.Success;

        notifyListeners();
        return bankData;
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
