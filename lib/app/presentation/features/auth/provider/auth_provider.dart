import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/domain/exception_handler.dart';
import 'package:max_4_u/app/domain/model.dart';
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

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
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
  Future<AppResponseModelData> signUp({required String phoneNumber}) async {
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
        data: body,
      );
      final data = response.data;
      print('$_status');
      _status = data['status'];

      if (_status == true) {
        _status = data['status'];
        _message = data['message'];

        state = ViewState.Success;

        notifyListeners();
      } else {
        _message = data['message'];
        _status = data['status'];
        state = ViewState.Error;
        _message = data['error_data']['mobile_number'];
        notifyListeners();
      }
      return data;
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
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
        data: body,
      );

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _message = data['data']['message'];

        state = ViewState.Success;

        notifyListeners();
        return data['data'];
      } else {
        _status = false;
        _message = data['data']['message'];
        state = ViewState.Error;

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }

  //To fully register a user

  @override
  Future<void> registerUser({
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
        data: body,
      );

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        _message = data['data']['message'];
        state = ViewState.Success;
        notifyListeners();
        resDataData = ResponseDataData.fromJson(data['data']['response_data']);
        _userLevel = resDataData.userData![0].level!;

        await SecureStorage().saveUserLevel(_userLevel);

        updateNumber(_userLevel);
        return data['data'];
      } else {
        _message = data['data']['message'];
        state = ViewState.Error;
        _status = data['data']['status'];

        _message = data['data']['error_data']['password'];
        _message = data['data']['error_data']['email'];
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }

//Login user method
  @override
  Future<UpdatedBaseResponse> loginUser(
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
    print(body.toString());
    try {
      final response = await ApiService().authPostRequest(
        data: body,
      );

      final data = response.data;
      debugPrint(data.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        _message = data['data']['message'];

        state = ViewState.Success;
        resDataData = ResponseDataData.fromJson(data['data']['response_data']);
        _userLevel = resDataData.userData![0].level!;
        updateNumber(_userLevel);

        notifyListeners();
        //  return data;

        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;

        _errorMessage = data['data']['message'];

        _errorMessage = data['data']['error_data']['login_id'];

        notifyListeners();
        //return data['data'];
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else {
        _message = AppException.handleError(e).toString();
      }
      _message = AppException.handleError(e).toString();
      //  return UpdatedBaseResponse.fromError(_message);
      return ExceptionHandler.handleError(e);
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

    try {
      final response = await ApiService().authPostRequest(
        data: body,
      );

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = ViewState.Success;
        _status = data['data']['status'];
        _message = data['data']['message'];
        notifyListeners();
        return data['data'];
      } else {
        state = ViewState.Error;
        _message = data['data']['error_data']['receiving_medium'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
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
        data: body,
      );
      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        state = ViewState.Success;

        _message = data['data']['message'];

        notifyListeners();
        return data['data'];
      } else {
        _status = data['data']['status'];

        state = ViewState.Error;
        _message = data['data']['message'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
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
        data: body,
      );
      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        state = ViewState.Success;

        _message = data['message'];

        notifyListeners();
        return data['data'];
      } else {
        // print(status);
        state = ViewState.Error;
        _message = data['message'];

        wrongPassword = data['error_data']['password'];
        existEmail = data['error_data']['email'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }

  // _updateState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notifyListeners();
  //   });
  // }
}
