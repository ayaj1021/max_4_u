import 'package:max_4_u/app/config/constants.dart';

import 'package:http/http.dart' as http;
import 'package:max_4_u/app/database/database.dart';

class AuthService {
  Future<http.Response> postRequest(String body) async {
    // Code to send HTTP POST request
     String url = AppConstants.baseUrl;

    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Site-From': 'postman',
      },
    );
    return response;
  }

  Future<String> getUserPhone() async {
    // Code to get user phone from secure storage

   var number = await SecureStorage().getUserPhone();
   return number;
  }

  Future<void> saveUserPhone(String phone) async {
    // Code to save user phone to secure storage
    
    
     await SecureStorage().saveUserPhone(phone);
  }

  Future<String> getUserOtp() async {
    // Code to get user OTP from secure storage

    var otp = SecureStorage().getUserOtp();
    return otp;
  }

  Future<void> saveUserOtp(String otp) async {
    // Code to save user OTP to secure storage
    await SecureStorage().saveUserOtp(otp);
  }

  Future<void> saveUserName(String name) async {
    // Code to save user name to secure storage

    await SecureStorage().saveUserName(name);
  }

  Future<String> getUserName() async {
    // Code to get user name from secure storage
    var name = await SecureStorage().getUserName();
    return name;
  }
}
