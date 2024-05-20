import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage(
    iOptions: IOSOptions.defaultOptions,
    aOptions: AndroidOptions.defaultOptions,
  );
  saveUserPhone(String phoneNumber) async {
    await _storage.write(key: 'phone_number', value: phoneNumber);
  }

  getUserPhone() async {
    String? value = await _storage.read(key: 'phone_number');
    return value;
  }


 saveUserName(String name) async {
    await _storage.write(key: 'user_name', value: name);
  }

  getUserName() async {
    String? value = await _storage.read(key: 'user_name');
    return value;
  }



saveUserOtp(String otp) async {
    await _storage.write(key: 'user_otp', value: otp);
  }

  getUserOtp() async {
    String? value = await _storage.read(key: 'user_otp');
    return value;
  }





  saveUserType(bool value) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool("user_type", value);
    // print(accountType);
  }

  getUserType() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.getBool("user_type");
  }
}
