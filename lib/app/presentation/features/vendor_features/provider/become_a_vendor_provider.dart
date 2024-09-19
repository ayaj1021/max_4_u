import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';
import 'package:http_parser/http_parser.dart';

class BecomeAVendorProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _ninMessage = '';
  String get ninMessage => _ninMessage;

  double _uploadSent = 0;
  double _uploadTotal = 0;

  double get uploadSent => _uploadSent;
  double get uploadTotal => _uploadTotal;

  Future<UpdatedBaseResponse<dynamic>> uploadNinBvn({
    required String bvn,
    required String nin,
  }) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "submit_nin_bvn",
      "bvn": bvn,
      "nin": nin
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
    );
    final data = response.data;
    _status = data['data']['status'];
    _message = data['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;
        List errorData = data['data']['error_data'];

        //  _message =  data['data']['message'];
        if (errorData.isNotEmpty) {
          _message = data['data']['error_data']['bvn'] ??
              data['data']['error_data']['nin'];
        } else {
          _message = data['data']['message'];
        }

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

  Future<UpdatedBaseResponse<dynamic>> uploadNinIdCard({
    required String image,
    required String fileName,
  }) async {
    state = ViewState.Busy;
    _message = 'uploading your file...';
    notifyListeners();

    // String fileName = image.path.split('/').last;

    final body = FormData.fromMap({
      "request_type": "user",
      "action": "upload_nin",
      "nin_image": await MultipartFile.fromFile(
        image,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    log('${body}');

    final response = await ApiService().uploadFileServicePostRequest(
      data: body,
      onSendProgress: (sent, total) {
        log('count: $sent, total $total');
        _uploadSent = ((sent / total) * 100);
        print(((sent / total) * 100));
        // _uploadSent = sent;
        _uploadTotal = ((total / total) * 100);
        ;
        notifyListeners();
        print('$sent, $total');
      },
    );
    final data = response.data;
    _message = data['data']['message'];

    log('$_status');
    log('$response');

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
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

  Future<UpdatedBaseResponse<dynamic>> uploadPhoto({
    required File image,
    required String fileName,
  }) async {
    if (!await image.exists()) {
      throw Exception('File not found: ${image.path}');
    }
    state = ViewState.Busy;
    _message = 'uploading your image...';
    notifyListeners();

    final body = FormData.fromMap({
      "request_type": "user",
      "action": "upload_image",
      "selfie_image": await MultipartFile.fromFile(
        image.path,
        // _imageFile.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    log('$body');

    final response = await ApiService().uploadFileServicePostRequest(
      data: body,
      onSendProgress: (sent, total) {
        log('count: $sent, total $total');
        _uploadSent = ((sent / total) * 100);
        print(((sent / total) * 100));
        // _uploadSent = sent;
        _uploadTotal = ((total / total) * 100);
        ;
        notifyListeners();
        print('$sent, $total');
      },
    );

    final data = response.data;

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();

        return UpdatedBaseResponse.fromSuccess(data);
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
      } else if (e.response?.statusCode == 401) {
        _message = 'File too large';
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

  Future<UpdatedBaseResponse<dynamic>> sendBecomeVendorRequest() async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "submit_request",
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;

    _status = data['data']['status'];
    _message = data['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
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
}
