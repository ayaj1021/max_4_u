
import 'package:flutter/material.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class GetAllCustomersProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;
  List _data = [];
  List get data => _data;
  String _message = '';
  String get message => _message;
  String firstName = '';
  String lastName = '';
  String mobileNumber = '';
  String uniqueId = '';

  Future<void> getAllCustomers() async {
    final body = {
      "request_type": "reseller",
      "action": "load_my_clients",
      "current_page": 1
    };

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];

    if (_status == true) {
      final userData = response['data']['response_data']['data'];
      state = ViewState.Success;

      firstName = EncryptData.decryptAES('${userData[0]['first_name']}');
      lastName = EncryptData.decryptAES('${userData[0]['last_name']}');
      mobileNumber = EncryptData.decryptAES('${userData[0]['mobile_number']}');
      uniqueId = EncryptData.decryptAES('${userData[0]['unique_id']}');
    

      _data = userData;
      notifyListeners();
    } else {
      state = ViewState.Error;
      _status = response['data']['status'];
      _message = response['data']['message'];
      notifyListeners();
    }
  }
}
