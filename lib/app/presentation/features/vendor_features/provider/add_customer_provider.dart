import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
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

  Future<UpdatedBaseResponse<dynamic>> addCustomerWithNumber({
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

    try {
      await SecureStorage().saveCustomerPhoneNumber(phoneNumber);
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );
      final data = response.data;
      _status = data['data']['status'];
      _message = data['data']['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();

        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;

        var errorData = data['data']['error_data'];

        if (errorData == null || errorData.isEmpty) {
          _message = data['data']['message'];
        } else {
          _message = data['data']['error_data']['mobile_number'];
        }

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

  Future<UpdatedBaseResponse<dynamic>> addCustomerWithUserId({
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

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );
      final data = response.data;

      _status = data['data']['status'];
      _message = data['data']['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;
        _message = data['data']['message'];
        //  _message = response['data']['error_data']['mobile_number'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

  Future<UpdatedBaseResponse<dynamic>> verifyCustomerOtp({
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

    try {
      await SecureStorage().saveCustomerOtp(otp);

      final response = await ApiService().authPostRequest(
        data: body,
        // message: _message,
      );

      final data = response.data;

      _status = data['data']['status'];
      _message = data['data']['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;
        _message = data['data']['message'];
        //  _message = response['data']['error_data']['mobile_number'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

  Future<UpdatedBaseResponse<dynamic>> registerCustomer({
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

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );

      final data = response.data;
      _status = data['data']['status'];
      _message = data['data']['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _message = data['data']['message'];
        ViewState.Error;
        _status = data['data']['status'];

        wrongPassword = data['data']['error_data']['password'];
        existEmail = data['data']['error_data']['email'];
        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
