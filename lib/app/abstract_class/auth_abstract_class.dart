import 'package:flutter/material.dart';

abstract class AuthenticationProviderUseCase extends ChangeNotifier {
  Future<void> signUp({required String phoneNumber});
  Future<void> verifyOtp({required String otp});
  Future registerUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String confirmPassword});
  Future loginUser(
      {required String email, required String password});
  Future<void> forgotPassword({required String email});
  Future<void> verifyForgotPasswordOtp({required String otp});
  Future<void> changePassword(
      {required String newPassword, required String confirmNewPassword});
}
