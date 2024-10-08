import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/model/super_admin/audit_log_model.dart';
import 'package:max_4_u/app/service/service.dart';

class AuditLogProvider extends ChangeNotifier {
  bool isLoading = false;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;
  String firstName = '';
  String lastName = '';
  String uniqueId = '';

  AuditLogResponseData allAuditResponse = AuditLogResponseData();

  Future<UpdatedBaseResponse<dynamic>> getAllAuditLog() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "grand_admin",
      "action": "load_logs",
      "current_page": 1
    };
    log('$body');

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );
      final data = response.data;

      log('this is all user response $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['data']['status'];
        _message = data['data']['message'];

        allAuditResponse =
            AuditLogResponseData.fromJson(data['data']['response_data']);
        isLoading = false;

        firstName =
            EncryptData.decryptAES('${allAuditResponse.data![0].firstName}');
        lastName =
            EncryptData.decryptAES('${allAuditResponse.data![0].lastName}');
        uniqueId =
            EncryptData.decryptAES('${allAuditResponse.data![0].uniqueId}');
        log('This is $allAuditResponse');

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        _message = data['data']['message'];
        isLoading = false;

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
      isLoading = false;
      _status = false;
      //  state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      isLoading = false;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
