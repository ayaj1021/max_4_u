import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/user_response_model.dart';
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
  Future<void> signUp({required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Creating your account...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "mobile_number": phoneNumber,
    };
    await SecureStorage().saveUserPhone(phoneNumber);

    final response = await ApiService.instance.authPostRequest(
      body: body,
    );

    print('$body');

    _status = response['data']['status'];
    print('$_status');

    _message = response['data']['message'];
    print('$_status');

    try {
      if (_status == true) {
        _message = response['data']['message'];

        state = ViewState.Success;
        phoneController.clear();

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
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
        phoneController.clear();

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        wrongPassword = response['data']['error_data']['password'];
        existEmail = response['data']['error_data']['email'];
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
    _message = 'Logging in your account...';
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
    );
    // log(response);
    _status = response['data']['status'];
    _message = response['data']['message'];

    if (_status == true) {
      _status = response['data']['status'];
      _message = response['data']['message'];
      ViewState.Error;
      notifyListeners();
      return ResponseDataData.fromJson(response['data']['response_data']);
    } else {
      ViewState.Error;
      _status = response['data']['status'];

      wrongPassword = response['data']['error_data']['password'];
      existEmail = response['data']['error_data']['email'];
      notifyListeners();
    }
    return ResponseDataData();
    // notifyListeners();

    // return ResponseModel(
    //   valid: false,
    //   error: ErrorModel.fromJson(response),
    //   // statusCode: statusCode,
    //   state: ViewState.Error,
    //   message: _message,
    // );
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

    if (_status == true) {
      _status = response['data']['status'];
      _message = response['data']['message'];
      ViewState.Error;
      notifyListeners();
      final result =
          ResponseDataData.fromJson(response['data']['response_data']['data']);
      log('this is the result: $result');
      return result;
    } else {
      ViewState.Error;
      _status = response['data']['status'];
      _message = response['data']['message'];
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
