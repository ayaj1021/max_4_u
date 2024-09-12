import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/model/admin/get_all_app_admins_model.dart';
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
  String email = '';

  String vendorFirstName = '';
  String vendorLastName = '';
  String vendorPhoneNumber = '';

  String adminFirstName = '';
  String adminLastName = '';
  String adminPhoneNumber = '';

  String searchedText = '';

  AllAppUsersResponseData allAppUsers = AllAppUsersResponseData();
  AllAppVendorsResponseData allAppVendors = AllAppVendorsResponseData();
  AllAppAdminsResponseData allAppAdmins = AllAppAdminsResponseData();

  AllAppUsersResponseData searchUsers = AllAppUsersResponseData();

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
      data: body,
      // message: _message,
    );
    final data = response.data;

    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];

        allAppUsers =
            AllAppUsersResponseData.fromJson(data['data']['response_data']);
        isLoading = false;

        firstName = EncryptData.decryptAES(
            '${allAppUsers.data?.first.firstName}');
       
        lastName =
            EncryptData.decryptAES('${allAppUsers.data?.first.lastName}');
        phoneNumber = EncryptData.decryptAES(
            '${allAppUsers.data?.first.mobileNumber}');
        email =
            EncryptData.decryptAES('${allAppUsers.data?.first.email}');
        //log('This is $allAppUsers');
        updateSearch();

        notifyListeners();
        return allAppUsers;
      } else {
        _status = data['data']['status'];
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

  updateSearch() {
    if (searchedText.isEmpty) {
      searchUsers.data?.addAll(allAppUsers.data!);
    } else {
      searchUsers.data!.addAll(allAppUsers.data!
          .where((element) =>
              element.firstName!.toLowerCase().contains(searchedText))
          .toList());
    }
    notifyListeners();
  }

  searchUser(String userName) {
    searchedText = userName;
    updateSearch();
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
      data: body,
      // message: _message,
    );
    final data = response.data;

    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];

        allAppVendors =
            AllAppVendorsResponseData.fromJson(data['data']['response_data']);
        isLoading = false;

        vendorFirstName = EncryptData.decryptAES(
            '${allAppVendors.data?.first.firstName}');
        vendorLastName = EncryptData.decryptAES(
            '${allAppVendors.data?.first.lastName}');
        vendorPhoneNumber = EncryptData.decryptAES(
            '${allAppVendors.data?.first.mobileNumber}');
        log('This is $allAppVendors');

        notifyListeners();
        return allAppUsers;
      } else {
        _status = data['data']['status'];
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
      data: body,
      // message: _message,
    );

    final data = response.data;

    log('this is all admin response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  if (_status == true) {
        _status = data['data']['status'];

        allAppAdmins =
            AllAppAdminsResponseData.fromJson(data['data']['response_data']);
        isLoading = false;

        adminFirstName = EncryptData.decryptAES(
            '${allAppAdmins.data?.first.firstName}');
        adminLastName = EncryptData.decryptAES(
            '${allAppAdmins.data?.first.lastName}');
        adminPhoneNumber = EncryptData.decryptAES(
            '${allAppAdmins.data?.first.mobileNumber}');
        log('This is $allAppAdmins');

        notifyListeners();
        return allAppAdmins;
      } else {
        _status = data['data']['status'];
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
