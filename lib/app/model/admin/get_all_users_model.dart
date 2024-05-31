// To parse this JSON data, do
//
//     final getUsersModel = getUsersModelFromJson(jsonString);

import 'dart:convert';

GetUsersModel getUsersModelFromJson(String str) => GetUsersModel.fromJson(json.decode(str));

String getUsersModelToJson(GetUsersModel data) => json.encode(data.toJson());

class GetUsersModel {
    final Data? data;

    GetUsersModel({
        this.data,
    });

    factory GetUsersModel.fromJson(Map<String, dynamic> json) => GetUsersModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    final bool? status;
    final String? message;
    final AllUsersResponseData? responseData;
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
        responseData: json["response_data"] == null ? null : AllUsersResponseData.fromJson(json["response_data"]),
        errorData: json["error_data"] == null ? [] : List<dynamic>.from(json["error_data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData?.toJson(),
        "error_data": errorData == null ? [] : List<dynamic>.from(errorData!.map((x) => x)),
    };
}

class AllUsersResponseData {
    final List<Datum>? data;
    final String? currentPage;
    final int? totalData;
    final int? totalResult;

    AllUsersResponseData({
        this.data,
        this.currentPage,
        this.totalData,
        this.totalResult,
    });

    factory AllUsersResponseData.fromJson(Map<String, dynamic> json) => AllUsersResponseData(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        currentPage: json["current_page"],
        totalData: json["total_data"],
        totalResult: json["total_result"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "current_page": currentPage,
        "total_data": totalData,
        "total_result": totalResult,
    };
}

class Datum {
    final String? uniqueId;
    final String? lastName;
    final String? firstName;
    final String? email;
    final String? mobileNumber;
    final String? level;
    final String? status;
    final String? emailStatus;
    final DateTime? regDate;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uniqueId: json["unique_id"],
        lastName: json["last_name"],
        firstName: json["first_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        level: json["level"],
        status: json["status"],
        emailStatus: json["email_status"],
        regDate: json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
    );

    Map<String, dynamic> toJson() => {
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
