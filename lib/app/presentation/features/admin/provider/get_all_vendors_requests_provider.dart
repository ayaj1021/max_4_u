import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/model/admin/get_all_requests_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GetAllVendorRequestsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool _status = false;
  bool get status => _status;
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String uniqueId = '';

  VendorRequestResponseData allVendorRequest = VendorRequestResponseData();

  Future getAllVendorsRequests() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "load_become_vendor_request",
      "current_page": 1,
      "search_param": {
        "status": "" // '', incomplete pending OR confirmed
      }
    };
    log('$body');

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
      );
      final data = response.data;

      log('this is all user response $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];

        allVendorRequest =
            VendorRequestResponseData.fromJson(data['data']['response_data']);
        isLoading = false;

        firstName =
            EncryptData.decryptAES('${allVendorRequest.data![0].firstName}');
        lastName =
            EncryptData.decryptAES('${allVendorRequest.data![0].lastName}');

        uniqueId =
            EncryptData.decryptAES('${allVendorRequest.data![0].uniqueId}');
        log('This is $allVendorRequest');

        notifyListeners();
        return allVendorRequest;
      } else {
        _status = data['data']['status'];
        isLoading = false;

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }
}
