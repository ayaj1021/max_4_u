import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
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

  String _message = '';

  String wrongPassword = '';
  String existEmail = '';

  String _number = '';
  String _otp = '';
  String get otp => _otp;
  String get number => _number;
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  List _responseData = [];
  List get responseData => _responseData;

  Map<String, dynamic> _errorData = {};
  Map<String, dynamic> get errorData => _errorData;

  String _userName = '';
  String get userName => _userName;

  @override
  Future<void> signUp() async {
    state = ViewState.Busy;
    _message = 'Creating your account...';
    _updateState();

    final phoneNumber = phoneController.text.trim();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "mobile_number": phoneNumber,
    };
    await SecureStorage().saveUserPhone(phoneNumber);
    try {
      final response = await AppService().postRequest(
        body: json.encode(body),
      );
      print(response);

      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;
          phoneController.clear();
          _message = res['data']['message'];
          _updateState();
        } else {
          state = ViewState.Error;

          _message = _errorData['mobile_number'];
          _updateState();
        }
      } else {
        print(res['data']['error_data']['mobile_number']);

        state = ViewState.Error;
        _updateState();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      _updateState();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      _updateState();
    }
  }

  @override
  Future<void> verifyOtp() async {
    state = ViewState.Busy;
    _message = 'Verifying otp...';
    _updateState();
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
      final response = await AppService().postRequest(
        body: json.encode(body),
      );
      final res = jsonDecode(response.body);
      print(res);

      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;
          phoneController.clear();
          _message = res['data']['message'];
          _updateState();
        } else {
          state = ViewState.Error;

          _message = res['data']['error_data']['token'];
          _updateState();
        }
      } else {
        print(res['data']['error_data']['token']);

        state = ViewState.Error;
        _updateState();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      _updateState();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      _updateState();
    }
  }

  @override
  Future<void> registerUser() async {
    state = ViewState.Busy;
    _message = 'Setting your profile...';
    _updateState();

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

    final _userName = firstNameController.text.trim();

    await SecureStorage().saveUserName(_userName);

    print(body);

    try {
      final response = await AppService().postRequest(
        body: json.encode(body),
      );
      final res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        if (_status == true) {
          state = ViewState.Success;
          emailController.clear();
          firstNameController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          _message = res['data']['message'];
          _updateState();
        } else {
          state = ViewState.Error;

          _message = res['data']['error_data']['token'];
          _updateState();
        }
      } else {
        print(res['data']['error_data']['token']);

        state = ViewState.Error;
        _updateState();
      }
      //   _status = res['data']['status'];
      //   _message = res['data']['message'];
      //   emailController.clear();
      //   firstNameController.clear();
      //   passwordController.clear();
      //   confirmPasswordController.clear();
      //   state = ViewState.Success;
      //   _updateState();
      // } else {
      //   _status = res['data']['status'];
      //   _message = res['data']['message'];
      //   wrongPassword = res['data']['error_data']['email'];
      //   existEmail = res['data']['error_data']['password'];

      //   state = ViewState.Error;
      //   _updateState();
      // }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      _updateState();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      _updateState();
    }
  }

  _updateState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
