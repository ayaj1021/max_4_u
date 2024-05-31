import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/service/service.dart';

class ActivateAutoRenewalProvider extends ChangeNotifier {
  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> activateAutoRenewal({
    required String phoneNumber,
    required String productCode,
    required String amount,
    required DateTime startDate,
    required DateTime endDate,
    required String intervalDaily,
  }) async {
    final userId = await SecureStorage().getUniqueId();
    final body = {
      "request_type": "user",
      "action": "set_renewal",
      "product_code": productCode,
      "number": phoneNumber,
      "amount": amount,
      "interval": intervalDaily,
      "start_date": startDate,
      "end_data": endDate,
      "user_id": userId,
    };

    final response = await ApiService.instance.servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];

    if (_status == true) {
      _message = response['data']['message'];

      notifyListeners();
    } else {
      _status = response['data']['status'];
      _message = response['data']['message'];
      _message = response['data']['error_data']['start_date'];
      _message = response['data']['error_data']['end_date'];
      notifyListeners();
    }
  }
}
