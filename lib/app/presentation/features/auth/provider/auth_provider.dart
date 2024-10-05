import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
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
  Future<UpdatedBaseResponse<dynamic>> signUp(
      {required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Creating your account...';
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "verify_receiving_medium",
      "mobile_number": phoneNumber,
    };

    await SecureStorage().saveUserPhone(phoneNumber);
    try {
      final response = await ApiService().authPostRequest(
        data: body,
      );
      final data = response.data;

      _status = data['data']['status'];

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = ViewState.Success;

        notifyListeners();

        _status = data['data']['status'];
        _message = data['data']['message'];

        state = ViewState.Success;

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = false;

        state = ViewState.Error;
        _message = data['data']['message'];
        _status = data['data']['status'];

        _message = data['data']['error_data']['mobile_number'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      // Ensure all errors are wrapped in an UpdatedBaseResponse
      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    }
  }

//Verify otp
  @override
  Future<UpdatedBaseResponse<dynamic>> verifyOtp({required String otp}) async {
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
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = false;
        _message = data['data']['message'];
        state = ViewState.Error;

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    }
  }

  @override
  Future<UpdatedBaseResponse<dynamic>> registerUser({
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
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _message = data['data']['message'];
        state = ViewState.Error;
        _status = data['data']['status'];

        _message = data['data']['error_data']['password'] ??
            data['data']['error_data']['email'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

//Login user method
  @override
  Future<UpdatedBaseResponse<dynamic>> loginUser(
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

    try {
      final response = await ApiService().authPostRequest(
        data: body,
      );

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        _message = data['data']['message'];

        state = ViewState.Success;
        resDataData = ResponseDataData.fromJson(data['data']['response_data']);
        _userLevel = resDataData.userData![0].level!;
        updateNumber(_userLevel);

        notifyListeners();

        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;

        _message =
            data['data']['message'] ?? data['data']['error_data']['login_id'];

        notifyListeners();

        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

//Forgot password user method
  @override
  Future<UpdatedBaseResponse<dynamic>> forgotPassword(
      {required String email}) async {
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
        return UpdatedBaseResponse.fromSuccess(_message);
      } else {
        state = ViewState.Error;
        _message = data['data']['error_data']['receiving_medium'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

  //Verify otp forgot password method
  @override
  Future<UpdatedBaseResponse<dynamic>> verifyForgotPasswordOtp(
      {required String otp}) async {
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
        return UpdatedBaseResponse.fromSuccess(_message);
      } else {
        _status = data['data']['status'];

        state = ViewState.Error;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

//Change password method
  @override
  Future<UpdatedBaseResponse<dynamic>> changePassword(
      {required String newPassword, required String confirmNewPassword}) async {
    state = ViewState.Busy;
    _message = 'Changing your password...';
    notifyListeners();

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

    try {
      final response = await ApiService().authPostRequest(
        data: body,
      );
      final data = response.data;

      log(response.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        state = ViewState.Success;

        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(_message);
      } else {
        state = ViewState.Error;

        var errorData = data['data']['error_data'];

        //  _message =  data['data']['message'];
        if (errorData!= null ) {
          _message = data['data']['error_data']['password'];
        } else {
          _message = data['data']['message'];
        }

         

        // _message =
        //     data['data']['message'] ?? data['data']['error_data']['password'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
