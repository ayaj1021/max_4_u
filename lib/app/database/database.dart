import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
saveUserType(bool value) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool("user_type", value);
    // print(accountType);
  }
getUserType()async{
     SharedPreferences sf = await SharedPreferences.getInstance();
     sf.getBool("user_type");
}
}