// To parse this JSON data, do
//
//     final getAppUsersModel = getAppUsersModelFromJson(jsonString);

import 'dart:convert';

GetAppUsersModel getAppUsersModelFromJson(String str) =>
    GetAppUsersModel.fromJson(json.decode(str));

String getAppUsersModelToJson(GetAppUsersModel data) =>
    json.encode(data.toJson());

class GetAppUsersModel {
  final AppUsersData? data;

  GetAppUsersModel({
    this.data,
  });

  factory GetAppUsersModel.fromJson(Map<String, dynamic> json) =>
      GetAppUsersModel(
        data: json["data"] == null ? null : AppUsersData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final bool? status;
  final String? message;
  final AllAppUsersResponseData? responseData;
  final List<dynamic>? errorData;

  Data({
    this.status,
    this.message,
    this.responseData,
    this.errorData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        message: json["message"],
        responseData: json["response_data"] == null
            ? null
            : AllAppUsersResponseData.fromJson(json["response_data"]),
        errorData: json["error_data"] == null
            ? []
            : List<dynamic>.from(json["error_data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData?.toJson(),
        "error_data": errorData == null
            ? []
            : List<dynamic>.from(errorData!.map((x) => x)),
      };
}

class AllAppUsersResponseData {
  final AppUsersData? data;

  AllAppUsersResponseData({
    this.data,
  });

  AllAppUsersResponseData copyWith({
    AppUsersData? data,
  }) =>
      AllAppUsersResponseData(
        data: data ?? this.data,
      );

  factory AllAppUsersResponseData.fromJson(Map<String, dynamic> json) =>
      AllAppUsersResponseData(
        data: json["data"] == null ? null : AppUsersData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class AppUsersData {
  final bool? status;
  final String? message;
  final ResponseData? responseData;
  final List<dynamic>? errorData;

  AppUsersData({
    this.status,
    this.message,
    this.responseData,
    this.errorData,
  });

  AppUsersData copyWith({
    bool? status,
    String? message,
    ResponseData? responseData,
    List<dynamic>? errorData,
  }) =>
      AppUsersData(
        status: status ?? this.status,
        message: message ?? this.message,
        responseData: responseData ?? this.responseData,
        errorData: errorData ?? this.errorData,
      );

  factory AppUsersData.fromJson(Map<String, dynamic> json) => AppUsersData(
        status: json["status"],
        message: json["message"],
        responseData: json["response_data"] == null
            ? null
            : ResponseData.fromJson(json["response_data"]),
        errorData: json["error_data"] == null
            ? []
            : List<dynamic>.from(json["error_data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData?.toJson(),
        "error_data": errorData == null
            ? []
            : List<dynamic>.from(errorData!.map((x) => x)),
      };
}

class ResponseData {
  final List<UserData>? data;
  final String? currentPage;
  final int? totalData;
  final int? totalResult;
  final int? totalConsumer;
  final int? totalActiveConsumer;
  final int? totalInactiveConsumer;
  final int? totalVendor;
  final int? totalActiveVendor;
  final int? totalInactiveVendor;
  final int? totalAdmin;

  ResponseData({
    this.data,
    this.currentPage,
    this.totalData,
    this.totalResult,
    this.totalConsumer,
    this.totalActiveConsumer,
    this.totalInactiveConsumer,
    this.totalVendor,
    this.totalActiveVendor,
    this.totalInactiveVendor,
    this.totalAdmin,
  });

  ResponseData copyWith({
    List<UserData>? data,
    String? currentPage,
    int? totalData,
    int? totalResult,
    int? totalConsumer,
    int? totalActiveConsumer,
    int? totalInactiveConsumer,
    int? totalVendor,
    int? totalActiveVendor,
    int? totalInactiveVendor,
    int? totalAdmin,
  }) =>
      ResponseData(
        data: data ?? this.data,
        currentPage: currentPage ?? this.currentPage,
        totalData: totalData ?? this.totalData,
        totalResult: totalResult ?? this.totalResult,
        totalConsumer: totalConsumer ?? this.totalConsumer,
        totalActiveConsumer: totalActiveConsumer ?? this.totalActiveConsumer,
        totalInactiveConsumer:
            totalInactiveConsumer ?? this.totalInactiveConsumer,
        totalVendor: totalVendor ?? this.totalVendor,
        totalActiveVendor: totalActiveVendor ?? this.totalActiveVendor,
        totalInactiveVendor: totalInactiveVendor ?? this.totalInactiveVendor,
        totalAdmin: totalAdmin ?? this.totalAdmin,
      );

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        data: json["data"] == null
            ? []
            : List<UserData>.from(
                json["data"]!.map((x) => UserData.fromJson(x))),
        currentPage: json["current_page"],
        totalData: json["total_data"],
        totalResult: json["total_result"],
        totalConsumer: json["total_consumer"],
        totalActiveConsumer: json["total_active_consumer"],
        totalInactiveConsumer: json["total_inactive_consumer"],
        totalVendor: json["total_vendor"],
        totalActiveVendor: json["total_active_vendor"],
        totalInactiveVendor: json["total_inactive_vendor"],
        totalAdmin: json["total_admin"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "current_page": currentPage,
        "total_data": totalData,
        "total_result": totalResult,
        "total_consumer": totalConsumer,
        "total_active_consumer": totalActiveConsumer,
        "total_inactive_consumer": totalInactiveConsumer,
        "total_vendor": totalVendor,
        "total_active_vendor": totalActiveVendor,
        "total_inactive_vendor": totalInactiveVendor,
        "total_admin": totalAdmin,
      };
}

class UserData {
  final int? id;
  final String? uniqueId;
  final String? lastName;
  final String? firstName;
  final String? email;
  final String? mobileNumber;
  final String? level;
  final String? status;
  final String? emailStatus;
  final DateTime? regDate;

  UserData({
    this.id,
    this.uniqueId,
    this.lastName,
    this.firstName,
    this.email,
    this.mobileNumber,
    this.level,
    this.status,
    this.emailStatus,
    this.regDate,
  });

  UserData copyWith({
    int? id,
    String? uniqueId,
    String? lastName,
    String? firstName,
    String? email,
    String? mobileNumber,
    String? level,
    String? status,
    String? emailStatus,
    DateTime? regDate,
  }) =>
      UserData(
        id: id ?? this.id,
        uniqueId: uniqueId ?? this.uniqueId,
        lastName: lastName ?? this.lastName,
        firstName: firstName ?? this.firstName,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        level: level ?? this.level,
        status: status ?? this.status,
        emailStatus: emailStatus ?? this.emailStatus,
        regDate: regDate ?? this.regDate,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        uniqueId: json["unique_id"],
        lastName: json["last_name"],
        firstName: json["first_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        level: json["level"],
        status: json["status"],
        emailStatus: json["email_status"],
        regDate:
            json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "last_name": lastName,
        "first_name": firstName,
        "email": email,
        "mobile_number": mobileNumber,
        "level": level,
        "status": status,
        "email_status": emailStatus,
        "reg_date": regDate?.toIso8601String(),
      };
}
