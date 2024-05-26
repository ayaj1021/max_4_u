import 'package:flutter/material.dart';
import 'package:max_4_u/app/model/response_model.dart';
import 'package:max_4_u/app/model/user_account_model.dart';

abstract class AuthenticationProviderUseCase extends ChangeNotifier {
  Future<void> signUp();
  Future<void> verifyOtp();
  Future<void> registerUser();
  Future<ResponseModel<DataResponse>> loginUser({required String email, required String password});
  Future<void> forgotPassword();
  Future<void> verifyForgotPasswordOtp();
  Future<void> changePassword();

}
