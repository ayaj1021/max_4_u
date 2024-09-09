import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/model/super_admin/audit_log_model.dart';
import 'package:max_4_u/app/service/service.dart';

class AuditLogProvider extends ChangeNotifier {
  bool isLoading = false;
  bool _status = false;
  bool get status => _status;
  String firstName = '';
  String lastName = '';
  String uniqueId = '';

  AuditLogResponseData allAuditResponse = AuditLogResponseData();

  Future getAllAuditLog() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "grand_admin",
      "action": "load_logs",
      "current_page": 1
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );
    final data = response.data;
    _status = data['status'];
    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['status'];

        allAuditResponse = AuditLogResponseData.fromJson(data['response_data']);
        isLoading = false;

        firstName =
            EncryptData.decryptAES('${allAuditResponse.data![0].firstName}');
        lastName =
            EncryptData.decryptAES('${allAuditResponse.data![0].lastName}');
        uniqueId =
            EncryptData.decryptAES('${allAuditResponse.data![0].uniqueId}');
        log('This is $allAuditResponse');

        notifyListeners();
        return allAuditResponse;
      } else {
        _status = data['status'];
        isLoading = false;

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // notifyListeners();
    }
  }
}
