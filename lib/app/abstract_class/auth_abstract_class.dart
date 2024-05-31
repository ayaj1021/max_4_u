import 'package:flutter/material.dart';
import 'package:max_4_u/app/model/user_response_model.dart';

abstract class AuthenticationProviderUseCase extends ChangeNotifier {
  Future<void> signUp({required String phoneNumber});
  Future<void> verifyOtp({required String otp});
  Future<ResponseDataData> registerUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String confirmPassword});
  Future<ResponseDataData> loginUser(
      {required String email, required String password});
  Future<void> forgotPassword();
  Future<void> verifyForgotPasswordOtp();
  Future<void> changePassword(
      {required String newPassword, required String confirmNewPassword});
}
