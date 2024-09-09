import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/domain/exception_handler.dart';
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
      data: body,
    );
    final data = response.data;
    _status = data['status'];
    _message = data['message'];

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['status'];
        state = ViewState.Error;

        _message = data['error_data']['bvn'] ?? data['error_data']['nin'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // notifyListeners();
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
    _message = data['message'];

    log('$_status');
    log('$response');

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['status'];
        state = ViewState.Error;
        _message = data['message'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // notifyListeners();
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

    _status = data['status'];
    _message = data['message'];

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['status'];
        state = ViewState.Error;
        _message = data['message'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // _message =
      //     'An error occurred while uploading the image. Please try again.';
      // notifyListeners();
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
      data: body,
      // message: _message,
    );

    final data = response.data;

    _status = data['status'];
    _message = data['message'];

    log('$_status');
    log('$response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['status'];
        state = ViewState.Error;
        _message = data['message'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // notifyListeners();
    }
  }
}
