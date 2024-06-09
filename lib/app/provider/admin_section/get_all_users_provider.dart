import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/model/admin/get_all_app_users_model.dart';
import 'package:max_4_u/app/model/admin/get_all_app_vendors_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GetAllAppUsers extends ChangeNotifier {
  bool isLoading = false;
  bool _status = false;
  bool get status => _status;
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';

    String vendorFirstName = '';
  String vendorLastName = '';
  String vendorPhoneNumber = '';

    String adminFirstName = '';
  String adminLastName = '';
  String adminPhoneNumber = '';

  AllAppUsersResponseData allAppUsers = AllAppUsersResponseData();
  AllAppVendorsResponseData allAppVendors = AllAppVendorsResponseData();
  AllAppVendorsResponseData allAppAdmins = AllAppVendorsResponseData();

  Future getAllUsers() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "load_users",
      "current_page": 1,
      "search_param": {
        "status": "", // '', active OR inactive
        "name": ""
      }
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];

        allAppUsers =
            AllAppUsersResponseData.fromJson(response['data']['response_data']);
        isLoading = false;

        firstName = EncryptData.decryptAES('${allAppUsers.data![0].firstName}');
        lastName = EncryptData.decryptAES('${allAppUsers.data![0].lastName}');
        phoneNumber =
            EncryptData.decryptAES('${allAppUsers.data![0].mobileNumber}');
        log('This is $allAppUsers');

        notifyListeners();
        return allAppUsers;
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
  }

  Future getAlLVendors() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "load_vendors",
      "current_page": 1,
      "search_param": {
        "status": "", // '', active OR inactive
        "name": ""
      }
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];

        allAppVendors =
            AllAppVendorsResponseData.fromJson(response['data']['response_data']);
        isLoading = false;

        vendorFirstName = EncryptData.decryptAES('${allAppVendors.data![0].firstName}');
        vendorLastName = EncryptData.decryptAES('${allAppVendors.data![0].lastName}');
        vendorPhoneNumber =
            EncryptData.decryptAES('${allAppVendors.data![0].mobileNumber}');
        log('This is $allAppVendors');

        notifyListeners();
        return allAppUsers;
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
  }


   Future getAllAdmins() async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "grand_admin",
      "action": "load_admins",
      "current_page": 1,
      "search_param": {
        "status": "", // '', active OR inactive
        "name": ""
      }
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];

        allAppAdmins =
            AllAppVendorsResponseData.fromJson(response['data']['response_data']);
        isLoading = false;

        adminFirstName = EncryptData.decryptAES('${allAppAdmins.data![0].firstName}');
        adminLastName = EncryptData.decryptAES('${allAppAdmins.data![0].lastName}');
        adminPhoneNumber =
            EncryptData.decryptAES('${allAppAdmins.data![0].mobileNumber}');
        log('This is $allAppVendors');

        notifyListeners();
        return allAppAdmins;
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
  }
}
