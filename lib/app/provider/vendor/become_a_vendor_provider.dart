import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';
import 'package:http_parser/http_parser.dart';

class BecomeAVendorProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  String _bvnMessage = '';
  String get bvnMessage => _bvnMessage;

  String _ninMessage = '';
  String get ninMessage => _ninMessage;

  Future<void> uploadNinBvn({
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
      body: body,
      // message: _message,
    );

    _status = response['data']['status'];
    _message = response['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;
        _message = response['data']['message'];

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
        _bvnMessage = response['data']['error_data']['bvn'];
        _ninMessage = response['data']['error_data']['nin'];

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }

  Future<void> uploadNinIdCard({
    required String image,
    required String fileName,
  }) async {
    state = ViewState.Busy;
    _message = 'uploading your file...';
    notifyListeners();

    // String fileName = image.path.split('/').last;

    final data = FormData.fromMap({
      "request_type": "user",
      "action": "upload_nin",
      "nin_image": await MultipartFile.fromFile(
        image,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    log('${data}');

    final response = await ApiService().uploadFileServicePostRequest(
      data: data,
    );

    //   _status = response['data']['status'];
    _message = response['data']['message'];

    log('$_status');
    log('$response');

    try {
      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;
        _message = response['data']['message'];

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }

  Future<void> uploadPhoto({
    required File image,
    required String fileName,
  }) async {
    if (!await image.exists()) {
      throw Exception('File not found: ${image.path}');
    }
    state = ViewState.Busy;
    _message = 'uploading your image...';
    notifyListeners();

    final data = FormData.fromMap({
      "request_type": "user",
      "action": "upload_image",
      "selfie_image": await MultipartFile.fromFile(
        image.path,
        // _imageFile.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    log('$data');

    final response = await ApiService().uploadFileServicePostRequest(
      data: data,

      // message: _message,
    );

    _status = response['data']['status'];
    _message = response['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;
        _message = response['data']['message'];

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      // _message =
      //     'An error occurred while uploading the image. Please try again.';
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  Future<void> sendBecomeVendorRequest() async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "submit_request",
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );

    _status = response['data']['status'];
    _message = response['data']['message'];

    log('$_status');
    log('$response');
    try {
      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;
        _message = response['data']['message'];

        notifyListeners();
      } else {
        _status = response['data']['status'];
        state = ViewState.Error;
        _message = response['data']['message'];
       

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      notifyListeners();
    }
  }
}
