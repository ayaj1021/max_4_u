import 'package:flutter/material.dart';

import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class CancelAutoRenewalProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> cancelAutoRenewal({
    required String id,

  }) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();
   
    final body = {
      "request_type": "user",
      "action": "cancel_renewal",
     
      "renewal_id": id
    };

    debugPrint(body.toString());

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );

    _status = response['data']['status'];
    if (_status == true) {
      _status = response['data']['status'];
      state = ViewState.Success;
      _message = response['data']['message'];

      notifyListeners();
    } else {
      state = ViewState.Error;
      _status = response['data']['status'];
      _message = response['data']['message'];
    

      notifyListeners();
    }
  }
}
