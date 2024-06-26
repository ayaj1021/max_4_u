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

  Future<void> buyAirtime(
      {required String amount,
      required String productCode,
      required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final id = await SecureStorage().getEncryptedID();

    final body = {
      "request_type": "user",
      "action": "buy_airtime",
      "product_code": productCode,
      "user_id": id,
      "number": phoneNumber,
      "amount": amount,
    };
    debugPrint('$body');

    // final encryptedId = await SecureStorage().getUserEncryptedId();

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );

    _status = response['data']['status'];
    _message = response['data']['message'];

    debugPrint('$_status');
    debugPrint('$response');
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
        _message = response['data']['error_data']['number'];
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      _status = false;
      notifyListeners();
    }
  }
}
