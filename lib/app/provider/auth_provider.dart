
import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/user_response_model.dart';
import 'package:max_4_u/app/service/service.dart';

class AuthProviderImpl extends ChangeNotifier
    implements AuthenticationProviderUseCase {
  ViewState state = ViewState.Idle;

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

  ResponseDataData resDataData = ResponseDataData();

  String _userName = '';
  String get userName => _userName;

  String _email = '';
  String get email => _email;

  String _userLevel = '';

  String get userLevel => _userLevel;

  void updateNumber(String newUserLevel) {
    _userLevel = newUserLevel;
    notifyListeners();
  }

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
    try {
      final response = await ApiService().authPostRequest(
        body: body,
        // message: _message,
      );

      _status = response['data']['status'];
      print('$_status');

      if (_status == true) {
        _message = response['data']['message'];

        state = ViewState.Success;

        notifyListeners();
      } else {
        _message = response['error_data']['mobile_number'];
        _status = response['data']['status'];
        state = ViewState.Error;
        //  _message = response.data['data']['message'];
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());

      state = ViewState.Error;
      _status = false;

      notifyListeners();
      // return ExceptionHandler.handleError(e);
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
    try {
      final response = await ApiService().authPostRequest(
        body: body,
      );
      _status = response['data']['status'];
      print(response);

      _message = response['data']['message'];

      if (_status == true) {
        _message = response['data']['message'];

        state = ViewState.Success;

        notifyListeners();
      } else {
        _status = false;
        _message = response['data']['message'];
        state = ViewState.Error;

        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _status = false;
//_message = e.toString();
      notifyListeners();
      // return ExceptionHandler.handleError(e);
    }
  }

  //To fully register a user

  @override
  Future registerUser({
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

    try {
      final response = await ApiService().authPostRequest(
        body: body,
        // message: _message,
      );

      _status = response['data']['status'];
        _message = response['data']['message'];
      if (_status == true) {
        _status = response['data']['status'];
        _message = response['data']['message'];
        state = ViewState.Success;
        notifyListeners();
        resDataData =
            ResponseDataData.fromJson(response['data']['response_data']);
        _userLevel = resDataData.userData![0].level!;
        updateNumber(_userLevel);

        return resDataData;
      } else {
        _message = response['data']['message'];
        state = ViewState.Error;
        _status = response['data']['status'];

        _message = response['data']['error_data']['password'];
        _message = response['data']['error_data']['email'];
        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _status = false;
    
      notifyListeners();
      //  return ExceptionHandler.handleError(e);
    }
  }

//Login user method
  @override
  Future loginUser({required String email, required String password}) async {
    state = ViewState.Busy;
    _message = 'Logging in your account...';
    notifyListeners();
    final body = {
      "request_type": "general",
      "action": "login",
      "login_id": email,
      "password": password,
    };

    await SecureStorage().saveUserPassword(password);
    try {
      final response = await ApiService().authPostRequest(
        body: body,
      );
      print(response);
      _status = response['data']['status'];
      // _message = response['data']['message'];

      if (_status == true) {
        _status = response['data']['status'];
        _message = response['data']['message'];
        state = ViewState.Success;
        resDataData =
            ResponseDataData.fromJson(response['data']['response_data']);
        _userLevel = resDataData.userData![0].level!;
        updateNumber(_userLevel);

        notifyListeners();
        return resDataData;
      } else {
        state = ViewState.Error;
        _status = false;

        _message = response['data']['message'];

        _message = response['data']['error_data']['login_id'];
        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _status = false;
      // _message = e.toString();
      notifyListeners();
    }
  }

//Forgot password user method
  @override
  Future<void> forgotPassword({required String email}) async {
    state = ViewState.Busy;
    _message = 'Verifying your email...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "receiving_medium": email
    };

    _email = email;
    await SecureStorage().saveUserEmail(_email);
    _email = await SecureStorage().getUserEmail();

    print(body);
    try {
      final response = await ApiService().authPostRequest(
        body: body,
      );
      _status = response['data']['status'];
      _message = response['data']['message'];

      if (_status == true) {
        state = ViewState.Success;

        _message = response['data']['message'];
        notifyListeners();
      } else {
        state = ViewState.Error;
        _message = response['data']['error_data']['receiving_medium'];

        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _status = false;
      //  _message = e.toString();
      notifyListeners();
    }
  }

  //Verify otp forgot password method
  @override
  Future<void> verifyForgotPasswordOtp({required String otp}) async {
    state = ViewState.Busy;
    _message = 'Verifying your otp...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_otp",
      "medium_id": _email,
      "token": otp,
    };

    _email = await SecureStorage().getUserEmail();

    await SecureStorage().saveUserOtp(otp);

    print(body);
    try {
      final response = await ApiService().authPostRequest(
        body: body,
      );

      _message = response['data']['message'];

      _status = response['data']['status'];
      if (_status == true) {
        state = ViewState.Success;

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
      _status = false;
      // _message = e.toString();
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
    try {
      final response = await ApiService().authPostRequest(
        body: body,
      );

      _message = response['data']['message'];

      _status = response['data']['status'];

      if (_status == true) {
        state = ViewState.Success;

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
      _status = false;
      // _message = e.toString();
      notifyListeners();
    }
  }

  // _updateState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notifyListeners();
  //   });
  // }
}
