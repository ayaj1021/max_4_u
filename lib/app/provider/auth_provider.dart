import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/response_model.dart';
import 'package:max_4_u/app/model/user_account_model.dart';
import 'package:max_4_u/app/service/service.dart';

class AuthProviderImpl extends ChangeNotifier
    implements AuthenticationProviderUseCase {
  ViewState state = ViewState.Idle;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  String wrongPassword = '';
  String existEmail = '';

  String _number = '';
  String _otp = '';
  String get otp => _otp;
  String get number => _number;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;


  List<dynamic> _data = [];
  List<dynamic> get data => _data;

  List<dynamic> _beneficiary = [];
  List<dynamic> get beneficiary => _beneficiary;

  List<dynamic> _transaction = [];
  List<dynamic> get transaction => _transaction;

  List<dynamic> _autoRenewal = [];
  List<dynamic> get autoRenewal => _autoRenewal;

  List<dynamic> _services = [];
  List<dynamic> get services => _services;

  List<dynamic> _products = [];
  List<dynamic> get products => _products;

  String _userName = '';
  String get userName => _userName;

  String _email = '';
  String get email => _email;

// @override
//   Future<ResponseModel<dynamic>> register(Map<String, dynamic> data) async {
//     Response response = await _apiService.runCall(
//       _apiService.dio.post(Endpoints.register, data: data),
//     );

//     final int statusCode = response.statusCode ?? 000;

//     if (statusCode >= 200 && statusCode <= 300) {
//       return ResponseModel<dynamic>(
//         valid: true,
//         statusCode: statusCode,
//         message: response.statusMessage,
//         data: response.data,
//       );
//     }

//     return
// ResponseModel(
//       error: ErrorModel.fromJson(response.data),
//       statusCode: statusCode,
//       message: response.data['data']['error'],
//     );
//   }

//Sign up user
  @override
  Future<void> signUp() async {
    state = ViewState.Busy;
    _message = 'Creating your account...';
    notifyListeners();

    final phoneNumber = phoneController.text.trim();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "mobile_number": phoneNumber,
    };
    await SecureStorage().saveUserPhone(phoneNumber);
    try {
      final response = await ApiService.instance.authPostRequest(
        body: body,
      );

      print('$body');
      print(response.body);

      final res = jsonDecode(response.body);
      print(response.statusCode);
      _status = res['data']['status'];
      print('$_status');
      if (response.statusCode == 200) {
        print('$_status');
        if (_status == true) {
          state = ViewState.Success;
          phoneController.clear();
          _message = res['data']['message'];
          notifyListeners();
        } else {
          state = ViewState.Error;
          //  _message = res['data']['message'];
          _message = res['data']['error_data']['mobile_number'];
          notifyListeners();
        }
      } else {
        _message = res['data']['message'];
        //  print(res['data']['error_data']['mobile_number']);

        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

//Verify otp
  @override
  Future<void> verifyOtp() async {
    state = ViewState.Busy;
    _message = 'Verifying otp...';
    notifyListeners();
    final otp = otpController.text;
    _number = await SecureStorage().getUserPhone();
    final body = {
      "request_type": "general",
      "action": "verify_otp",
      "medium_id": '$_number',
      "token": otpController.text.trim(),
    };
    print(body);

    await SecureStorage().saveUserOtp(otp);

    try {
      final response = await ApiService.instance.authPostRequest(
        body: body,
      );
      final res = jsonDecode(response.body);
      print(res);

      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;
          otpController.clear();
          _message = res['data']['message'];
          notifyListeners();
        } else {
          state = ViewState.Error;

          _message = res['data']['message'];
          notifyListeners();
        }
      } else {
        _message = res['data']['message'];
        print(res['data']['error_data']['token']);
        //09072694395
        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //To fully register a user

  @override
  Future<void> registerUser() async {
    state = ViewState.Busy;
    _message = 'Setting your profile...';
    notifyListeners();

    _otp = await SecureStorage().getUserOtp();
    final body = {
      "request_type": "general",
      "action": "save_user_data",
      "email": emailController.text.trim(),
      "mobile_number": "$_number",
      "first_name": firstNameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "password": passwordController.text.trim(),
      "confirm_password": confirmPasswordController.text.trim(),
      "otp_code": "$_otp"
    };

    _userName = firstNameController.text;

    await SecureStorage().saveUserName(_userName);

    try {
      final response = await ApiService.instance.authPostRequest(
        body: body,
      );

      _userName = await SecureStorage().getUserName();

      _status = response['data']['status'];

      log('status: ${_status}');
      if (_status == true) {
        state = ViewState.Success;
        emailController.clear();
        firstNameController.clear();
        lastNameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        _message = response['data']['message'];
        //  _userData = UserData.fromJson(response.body);
        _data = response['data']['response_data']['data']['user_data'];
        _products = response['data']['response_data']['data']['products'];
        await SecureStorage().saveUserProducts(_products);
        _services = response['data']['response_data']['data']['services'];
        await SecureStorage().saveUserServices(_services);
        _autoRenewal =
            response['data']['response_data']['data']['auto_renewal'];
        _transaction =
            response['data']['response_data']['data']['transaction_history'];
        _beneficiary =
            response['data']['response_data']['data']['beneficiary_data'];
        notifyListeners();
      } else {
        log('If Else status: ${_status}');
        _message = response['data']['message'];

        wrongPassword = response['data']['error_data']['password'];
        existEmail = response['data']['error_data']['email'];
        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //   Future<DataResponseModel<dynamic>> register(Map<String, dynamic> data) async {
//     Response response = await _apiService.runCall(
//       _apiService.dio.post(Endpoints.register, data: data),
//     );

//     final int statusCode = response.statusCode ?? 000;

//     if (statusCode >= 200 && statusCode <= 300) {
//       return DataResponseModel<dynamic>(
//         valid: true,
//         statusCode: statusCode,
//         message: response.statusMessage,
//         data: response.data,
//       );
//     }

//     return
// ResponseModel(
//       error: ErrorModel.fromJson(response.data),
//       statusCode: statusCode,
//       message: response.data['data']['error'],
//     );
//   }

//Login user method
  @override
  Future<ResponseModel<DataResponse>> loginUser(
      {required String email, required String password}) async {
    state = ViewState.Busy;
    _message = 'Logging in your account...';
    notifyListeners();
    final body = {
      "request_type": "general",
      "action": "login",
      "login_id": email,
      "password": password,
    };
    print(body);
    final response = await ApiService.instance.authPostRequest(
      body: body,
    );
     _status = response['data']['status'];
     _message = response['data']['message'];
    if (_status == true) {
      return ResponseModel<DataResponse>(
        valid: true,
      // statusCode: statusCode,
        message: _message,
        data: DataResponse.fromJson(response['data']['response_data']),
        state: ViewState.Success,
      );
    }
    notifyListeners();
    return ResponseModel(
      error: ErrorModel.fromJson(response),
     // statusCode: statusCode,
      state: ViewState.Error,
      message: _message,
    );
  }

//Forgot password user method
  @override
  Future<void> forgotPassword() async {
    state = ViewState.Busy;
    _message = 'Verifying your email...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "receiving_medium": emailController.text.trim()
    };

    _email = emailController.text;

    await SecureStorage().saveUserEmail(_email);

    _email = await SecureStorage().getUserEmail();

    print(body);

    try {
      final response = await ApiService.instance.authPostRequest(
        body: body,
      );
      final res = jsonDecode(response.body);
      print(res);

      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;
          emailController.clear();

          _message = res['data']['message'];

          notifyListeners();
        } else {
          // print(status);
          state = ViewState.Error;
          _message = res['data']['error_data']['receiving_medium'];

          notifyListeners();
        }
      } else {
        print(res['data']['message']);

        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //Verify otp forgot password method
  @override
  Future<void> verifyForgotPasswordOtp() async {
    state = ViewState.Busy;
    _message = 'Verifying your otp...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_otp",
      "medium_id": _email,
      "token": otpController.text.trim(),
    };

    // _email = emailController.text;

    // await SecureStorage().saveUserEmail(_email);

    _email = await SecureStorage().getUserEmail();

    await SecureStorage().saveUserOtp(otpController.text);

    print(body);

    try {
      final response = await ApiService.instance.authPostRequest(
        body: body,
      );
      final res = jsonDecode(response.body);
      print(res);

      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;
          otpController.clear();

          _message = res['data']['message'];

          notifyListeners();
        } else {
          // print(status);
          state = ViewState.Error;
          _message = res['data']['message'];
          //  _message = res['data']['error_data']['receiving_medium'];

          notifyListeners();
        }
      } else {
        print(res['data']['message']);

        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

//Change password method
  @override
  Future<void> changePassword() async {
    state = ViewState.Busy;
    _message = 'Changing your password...';
    notifyListeners();
    // _email = emailController.text;
    _otp = await SecureStorage().getUserOtp();
    _email = await SecureStorage().getUserEmail();

    final body = {
      "request_type": "general",
      "action": "update_password",
      "medium_id": _email,
      "otp_code": _otp,
      "password": newPasswordController.text.trim(),
      "confirm_password": confirmNewPasswordController.text.trim()
    };

    print(body);

    try {
      final response = await ApiService.instance.authPostRequest(
        body: body,
      );
      final res = jsonDecode(response.body);
      print(res);

      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;
          newPasswordController.clear();
          confirmNewPasswordController.clear();

          //   _message = res['data']['message'];

          notifyListeners();
        } else {
          // print(status);
          state = ViewState.Error;
          //  _message = res['data']['message'];

          wrongPassword = res['data']['error_data']['password'];
          existEmail = res['data']['error_data']['email'];
          //  _message = res['data']['error_data']['receiving_medium'];

          notifyListeners();
        }
      } else {
        print(res['data']['message']);

        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

  // _updateState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notifyListeners();
  //   });
  // }
}
