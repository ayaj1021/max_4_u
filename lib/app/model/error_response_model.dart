// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final appResponseModel = appResponseModelFromJson(jsonString);

import 'dart:convert';

AppResponseModel appResponseModelFromJson(String str) =>
    AppResponseModel.fromJson(json.decode(str));

String appResponseModelToJson(AppResponseModel data) =>
    json.encode(data.toJson());

class AppResponseModel<T> {
  final int? statusCode;
  final String? status;
  final String message;
  final List<Error>? errors;

  AppResponseModel({
    this.statusCode,
    this.status,
    required this.message,
    this.errors,
  });

  factory AppResponseModel.fromJson(Map<String, dynamic> json) =>
      AppResponseModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        errors: json["errors"] == null
            ? []
            : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "errors": errors == null
            ? []
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'AppResponseModel(statusCode: $statusCode, status: $status, message: $message, errors: $errors)';
  }
}

class Error {
  final String? message;
  final String? field;

  Error({
    this.message,
    this.field,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        field: json["field"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "field": field,
      };
}
