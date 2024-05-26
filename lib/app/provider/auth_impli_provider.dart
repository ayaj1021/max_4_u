// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:max_4_u/app/abstract_class/auth_abstract_class.dart';
// import 'package:max_4_u/app/enums/view_state_enum.dart';
// import 'package:max_4_u/app/service/auth_service.dart';

// class AuthProviderImpl extends ChangeNotifier
//     implements AuthenticationProviderUseCase {
//   final AuthService _authService = AuthService();
//   ViewState state = ViewState.Idle;

//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//   final emailController = TextEditingController();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   String _message = '';
//   String _number = '';
//   String _otp = '';
//   bool _status = false;
//   String _userName = '';
//   List? data;

//   String get otp => _otp;
//   String get number => _number;
//   String get message => _message;
//   bool get status => _status;
//   String get userName => _userName;

//   @override
//   Future<void> signUp() async {
//     updateState(viewState: ViewState.Busy, message: 'Creating your account...');
//     final phoneNumber = phoneController.text.trim();
//     final body = json.encode({
//       "request_type": "general",
//       "action": "verify_receiving_medium",
//       "mobile_number": phoneNumber,
//     });

//     await _authService.saveUserPhone(phoneNumber);
//     _handleRequest(
//       body: body,
//       onSuccess: (res) {
//         _status = res['data']['status'];
//         if (_status) {
//           updateState(
//               viewState: ViewState.Success, message: res['data']['message']);
//           phoneController.clear();
//         } else {
//           updateState(
//               viewState: ViewState.Error,
//               message: res['data']['error_data']['mobile_number']);
//         }
//       },
//     );
//   }

//   @override
//   Future<void> verifyOtp() async {
//     updateState(viewState: ViewState.Busy, message: 'Verifying OTP...');
//     final otp = otpController.text;
//     _number = await _authService.getUserPhone();
//     final body = json.encode({
//       "request_type": "general",
//       "action": "verify_otp",
//       "medium_id": _number,
//       "token": otp.trim(),
//     });

//     await _authService.saveUserOtp(otp);
//     _handleRequest(
//       body: body,
//       onSuccess: (res) {
//         _status = res['data']['status'];
//         if (_status) {
//           updateState(
//               viewState: ViewState.Success, message: res['data']['message']);
//           otpController.clear();
//         } else {
//           updateState(
//               viewState: ViewState.Error, message: res['data']['message']);
//         }
//       },
//     );
//   }

//   @override
//   Future<void> registerUser() async {
//     updateState(viewState: ViewState.Busy, message: 'Setting your profile...');
//     _otp = await _authService.getUserOtp();
//     final body = json.encode({
//       "request_type": "general",
//       "action": "save_user_data",
//       "email": emailController.text.trim(),
//       "mobile_number": _number,
//       "first_name": firstNameController.text.trim(),
//       "last_name": lastNameController.text.trim(),
//       "password": passwordController.text.trim(),
//       "confirm_password": confirmPasswordController.text.trim(),
//       "otp_code": _otp,
//     });

//     _userName = firstNameController.text;
//     await _authService.saveUserName(_userName);
//     _handleRequest(
//       body: body,
//       onSuccess: (res) {
//         _status = res['data']['status'];
//         if (_status) {
//           updateState(
//               viewState: ViewState.Success, message: res['data']['message']);
//           emailController.clear();
//           firstNameController.clear();
//           lastNameController.clear();
//           passwordController.clear();
//           confirmPasswordController.clear();
//         } else {
//           updateState(
//               viewState: ViewState.Error, message: res['data']['message']);
//         }
//       },
//     );
//   }

//   @override
//   Future<void> loginUser() async {
//     updateState(viewState: ViewState.Busy, message: 'Logging in your account...');
//     final body = json.encode({
//       "request_type": "general",
//       "action": "login",
//       "login_id": emailController.text.trim(),
//       "password": passwordController.text.trim(),
//     });
    

//     _handleRequest(
//       body: body,
//       onSuccess: (res) {
//         _status = res['data']['status'];
//         print(_status);
//         if (_status) {
//           data = res['data']['response_data']['data']['user_data'];
//           updateState(
//               viewState: ViewState.Success, message: res['data']['message']);
//           emailController.clear();
//           passwordController.clear();
//         } else {
//           updateState(
//               viewState: ViewState.Error, message: res['data']['message']);
//           print(message);
//         }
//       },
//     );
//   }

//   void updateState({required ViewState viewState, required String message}) {
//     state = viewState;
//     _message = message;
//       notifyListeners();
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   notifyListeners();
//     // });
//   }

//   void _handleRequest({
//     required String body,
//     required Function(Map<String, dynamic> res) onSuccess,
//   }) async {
//     try {
//       final response = await _authService.postRequest(body);
//       final res = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         onSuccess(res);
//       } else {
//         updateState(
//             viewState: ViewState.Error,
//             message: res['data']['error_data']['message']);
//       }
//     } on SocketException catch (_) {
//       updateState(
//           viewState: ViewState.Error,
//           message: 'Network error. Please try again later');
//     } catch (e) {
//       updateState(viewState: ViewState.Error, message: e.toString());
//     }
//   }
// }
