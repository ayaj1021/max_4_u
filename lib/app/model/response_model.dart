import 'package:max_4_u/app/enums/view_state_enum.dart';

class ResponseModel<T> {
  late int? statusCode;
  late ErrorModel? error;
  late bool? valid = false;
  late String? message = '';
  late ViewState state;
  late T? data;

  ResponseModel({valid, message, statusCode, this.data, error, state}) {
    this.valid = valid ?? false;
    this.message = message ?? 'an error occurred please try again';
    this.statusCode = statusCode ?? 000;
    this.error = error ?? ErrorModel();
    this.state = state ?? ViewState.Idle;
  }
}


class ErrorModel {
  String? errorCode;
  String? message;
  ViewState? state;

  ErrorModel({this.errorCode, this.message, this.state});

  @override
  String toString() {
    return '{errorCode: $errorCode, message: $message}';
  }

  factory ErrorModel.fromJson(dynamic data) {
    return ErrorModel(
      errorCode: data['errorCode'] ?? '',
      message: data['data']['error'],
    );
  }
}