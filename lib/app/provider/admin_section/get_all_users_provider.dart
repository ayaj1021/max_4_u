import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/model/admin/get_all_users_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GetAllUsers extends ChangeNotifier {
  bool isLoading = false;
  bool _status = false;
  bool get status => _status;

  Future<AllUsersResponseData> getAllUsers() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "load_user_data",
    };
    log('$body');

    final response = await ApiService.instance.servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];

    try {
      if (_status == true) {
        _status = response['data']['status'];

        final result =
            AllUsersResponseData.fromJson(response['data']['response_data']);
        isLoading = false;

        notifyListeners();
        return result;
      } else {
        _status = response['data']['status'];
        isLoading = false;

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
    return response;
  }
}
