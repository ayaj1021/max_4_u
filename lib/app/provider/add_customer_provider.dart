import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class AddCustomerProvider extends ChangeNotifier {
  String wrongPassword = '';
  String existEmail = '';
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<void> addCustomerWithNumber({
    required String phoneNumber,
  }) async {
    state = ViewState.Busy;
    _message = 'Adding your customer...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "mobile_number": phoneNumber,
    };
    log('$body');
    await SecureStorage().saveCustomerPhoneNumber(phoneNumber);
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
        _message = response['data']['error_data']['mobile_number'];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }

  Future<void> addCustomerWithUserId({
    required String userId,
  }) async {
    state = ViewState.Busy;
    _message = 'Adding your customer...';
    notifyListeners();

    final body = {
      "request_type": "reseller",
      "action": "add_client",
      "client_type": "existing",
      "client_id": userId,
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

  Future<void> verifyCustomerOtp({
    required String otp,
  }) async {
    state = ViewState.Busy;
    _message = 'Verifying otp...';
    notifyListeners();

    final _customerNumber = await SecureStorage().getCustomerPhoneNumber();

    final body = {
      "request_type": "general",
      "action": "verify_otp",
      "medium_id": _customerNumber,
      "token": otp,
    };

    await SecureStorage().saveCustomerOtp(otp);
    log('$body');

    final response = await ApiService().authPostRequest(
      body: body,
      // message: _message,
    );

    _status = response.data['data']['status'];
    _message = response.data['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (_status == true) {
        _status = response.data['data']['status'];
        state = ViewState.Success;
        _message = response.data['data']['message'];

        notifyListeners();
      } else {
        _status = response.data['data']['status'];
        state = ViewState.Error;
        _message = response.data['data']['message'];
        //  _message = response['data']['error_data']['mobile_number'];

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }

  Future<void> registerCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String confirmPassword,
  }) async {
    state = ViewState.Busy;
    _message = 'Registering Customer...';
    notifyListeners();
    final _customerNumber = await SecureStorage().getCustomerPhoneNumber();
    final _otp = await SecureStorage().getCustomerOtp();
    final body = {
      "request_type": "reseller",
      "action": "add_client",
      "client_type": "new",
      "email": email,
      "mobile_number": _customerNumber,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "confirm_password": confirmPassword,
      "otp_code": _otp,
    };

    log(body.toString());
    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    // log(response);
    _status = response['data']['status'];
    _message = response['data']['message'];

    if (_status == true) {
      _status = response['data']['status'];
      state = ViewState.Success;
      _message = response['data']['message'];

      notifyListeners();
    } else {
      _message = response['data']['message'];
      ViewState.Error;
      _status = response['data']['status'];

      wrongPassword = response['data']['error_data']['password'];
      existEmail = response['data']['error_data']['email'];
      notifyListeners();
    }
  }
}
