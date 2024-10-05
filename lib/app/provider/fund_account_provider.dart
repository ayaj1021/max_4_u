import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class FundAccountProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = '';
  String get message => _message;
  String paymentUrl = '';
  String token = '';

  Future<UpdatedBaseResponse<dynamic>> initializePayment(
      {required String amount}) async {
    state = ViewState.Busy;
    _message = 'Funding account...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "initialize_payment",
      "amount": amount,
    };

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );
    final data = response.data;
    log(data.toString());

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];

        _message = data['data']['message'];
        state = ViewState.Success;
        paymentUrl = data['data']['response_data']['payment_link'];
        token = data['data']['response_data']['token'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
      //  _message = data['data']['message'];
        _status = data['data']['status'];

         var errorData = data['data']['error_data'];

        if (errorData != null && errorData.isNotEmpty) {
          _message = 
          
          //data['data']['error_data']['number'] ??
              data['data']['error_data']['amount'];
        } else {
          _message = data['data']['message'];
        }
        state = ViewState.Error;
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
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

  Future<UpdatedBaseResponse<dynamic>> verifyPayment(
      {required String paymentToken, required BuildContext context}) async {
    _isLoading = true;

    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "verify_transaction",
      "token": paymentToken,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
    );

    final data = response.data;
    _status = data['data']['status'];
    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];

        _message = data['data']['message'];
        _isLoading = false;

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _message = data['data']['message'];
        _status = data['data']['status'];
        _isLoading = false;
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
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
