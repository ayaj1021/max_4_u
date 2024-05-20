import 'package:max_4_u/app/config/constants.dart';

import 'package:http/http.dart' as http;

class AppService {
  Future<dynamic> postRequest(
      {
      Map<String, String>? headers,
      required Object body}) async {
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
}
