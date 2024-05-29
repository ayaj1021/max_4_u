import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class BecomeAVendorProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  String _bvnMessage = '';
  String get bvnMessage => _bvnMessage;

  String _ninMessage = '';
  String get ninMessage => _ninMessage;

  Future<void> uploadNinBvn({
    required String bvn,
    required String nin,
  }) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "submit_nin_bvn",
      "bvn": bvn,
      "nin": nin
    };
    log('$body');

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

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
        _bvnMessage = response['data']['error_data']['bvn'];
        _ninMessage = response['data']['error_data']['nin'];

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }
}
