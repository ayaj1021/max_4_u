import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/user_response_model.dart';
import 'package:max_4_u/app/service/service.dart';

class AuthProviderImpl extends ChangeNotifier
    implements AuthenticationProviderUseCase {
  ViewState state = ViewState.Idle;

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

//Sign up user
  @override
  Future<void> signUp({required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Creating your account...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "mobile_number": phoneNumber,
    };
    print(body);
    await SecureStorage().saveUserPhone(phoneNumber);

    final response = await ApiService.instance.authPostRequest(
      body: body,
      message: _message,
    );

    print(body);

    _status = response['data']['status'];
    print('$_status');

    try {
      if (_status == true) {
        _message = response['data']['message'];

        state = ViewState.Success;

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

//Verify otp
  @override
  Future<void> verifyOtp({required String otp}) async {
    state = ViewState.Busy;
    _message = 'Verifying otp...';
    notifyListeners();

    _number = await SecureStorage().getUserPhone();
    final body = {
      "request_type": "general",
      "action": "verify_otp",
      "medium_id": '$_number',
      "token": otp,
    };
    print(body);

    await SecureStorage().saveUserOtp(otp);

    final response = await ApiService.instance.authPostRequest(
      body: body,
    );
    _status = response['data']['status'];
    print(response);

    _message = response['data']['message'];

    try {
      if (_status == true) {
        _message = response['data']['message'];

        state = ViewState.Success;

        notifyListeners();
      } else {
        _message = response['data']['message'];
        _status = response['data']['status'];
        state = ViewState.Error;

        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //To fully register a user

  @override
  Future<ResponseDataData> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String confirmPassword,
  }) async {
    state = ViewState.Busy;
    _message = 'Starting up your account...';
    notifyListeners();

    _otp = await SecureStorage().getUserOtp();
    final body = {
      "request_type": "general",
      "action": "save_user_data",
      "email": email,
      "mobile_number": "$_number",
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "confirm_password": confirmPassword,
      "otp_code": "$_otp"
    };

    _userName = firstName;

    await SecureStorage().saveUserName(_userName);

    log(body.toString());
    final response = await ApiService.instance.authPostRequest(
      body: body,
      message: _message,
    );

    try {
      _status = response['data']['status'];
      if (_status == true) {
        // _status = response['data']['status'];
        _message = response['data']['message'];
        state = ViewState.Success;
        notifyListeners();
        final result =
            ResponseDataData.fromJson(response['response_data']['data']);
        log('this is the result: $result');
        return result;
      } else {
        _message = response['data']['message'];
        state = ViewState.Error;
        _status = response['data']['status'];

        wrongPassword = response['data']['error_data']['password'];
        existEmail = response['data']['error_data']['email'];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
    return response;
  }

//Login user method
  @override
  Future<ResponseDataData> loginUser(
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
    // log(response);
    _status = response['data']['status'];
    _message = response['data']['message'];
    try {
      if (_status == true) {
        _status = response['data']['status'];
        _message = response['data']['message'];
        state = ViewState.Success;
        notifyListeners();
        final result = ResponseDataData.fromJson(
            response['data']['response_data']['data']);
        log('this is the result: $result');
        return result;
      } else {
        state = ViewState.Error;
        _status = response['data']['status'];
        _message = response['data']['message'];
        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
    return response;
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

    final response = await ApiService.instance.authPostRequest(
      body: body,
    );
    _status = response['data']['status'];
    _message = response['data']['message'];

    try {
      if (_status == true) {
        state = ViewState.Success;
        emailController.clear();
        _message = response['data']['message'];
        notifyListeners();
      } else {
        state = ViewState.Error;
        _message = response['data']['error_data']['receiving_medium'];

        notifyListeners();
      }
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

    _email = await SecureStorage().getUserEmail();

    await SecureStorage().saveUserOtp(otpController.text);

    print(body);

    final response = await ApiService.instance.authPostRequest(
      body: body,
    );

    _message = response['data']['message'];

    try {
      _status = response['data']['status'];
      if (_status == true) {
        state = ViewState.Success;
        otpController.clear();

        _message = response['data']['message'];

        notifyListeners();
      } else {
        // print(status);
        state = ViewState.Error;
        _message = response['data']['message'];
        //  _message = res['data']['error_data']['receiving_medium'];

        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

//Change password method
  @override
  Future<void> changePassword(
      {required String newPassword, required String confirmNewPassword}) async {
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
      "password": newPassword,
      "confirm_password": confirmNewPassword
    };

    print(body);

    final response = await ApiService.instance.authPostRequest(
      body: body,
    );

    _message = response['data']['message'];

    try {
      _status = response['data']['status'];

      if (_status == true) {
        state = ViewState.Success;
        newPasswordController.clear();
        confirmNewPasswordController.clear();
        _message = response['data']['message'];

        notifyListeners();
      } else {
        // print(status);
        state = ViewState.Error;
        _message = response['data']['message'];

        wrongPassword = response['data']['error_data']['password'];
        existEmail = response['data']['error_data']['email'];
        //  _message = res['data']['error_data']['receiving_medium'];

        notifyListeners();
      }
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
