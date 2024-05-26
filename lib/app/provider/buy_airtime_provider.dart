import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class BuyAirtimeProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  final phoneNumber = TextEditingController();

  Future<void> buyAirtime(
      {required String amount, required String productCode}) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final id = await SecureStorage().getUniqueId();

    final body = {
      "request_type": "user",
      "action": "buy_airtime",
      "product_code": productCode,
      "user_id": id,
      "number": phoneNumber.text.trim(),
      "amount": amount,
    };
    log('$body');
    try {
      final response = await ApiService.instance.servicePostRequest(
        body: body,
        message: _message,
      );
      log('${response.body}');
      log('${response.statusCode}');
      final res = jsonDecode(response.body);
      log(res);
      _status = res['data']['status'];
      log('$_status');
      if (response.statusCode == 200) {
        if (_status == true) {
          state = ViewState.Success;
          phoneNumber.clear();
          _message = res['data']['message'];
          notifyListeners();
        } else {
          _message = res['data']['message'].toString();
          print(_message = res['data']['message']);

          state = ViewState.Error;
          notifyListeners();
        }
      } else {
        _message = res['data']['message'].toString();
        log(res['data']['message']);
        log(_message);

        state = ViewState.Error;
        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
