// To parse this JSON data, do
//
//     final appResponseModel = appResponseModelFromJson(jsonString);

import 'dart:convert';

AppResponseModel appResponseModelFromJson(String str) => AppResponseModel.fromJson(json.decode(str));

String appResponseModelToJson(AppResponseModel data) => json.encode(data.toJson());

class AppResponseModel {
    final AppResponseModelData? data;

    AppResponseModel({
        this.data,
    });

    factory AppResponseModel.fromJson(Map<String, dynamic> json) => AppResponseModel(
        data: json["data"] == null ? null : AppResponseModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class AppResponseModelData  <T>{
    final bool? status;
    final String? message;
    final List<dynamic>? responseData;
    final List<dynamic>? errorData;

    AppResponseModelData({
        this.status,
        this.message,
        this.responseData,
        this.errorData,
    });

    factory AppResponseModelData.fromJson(Map<String, dynamic> json) => AppResponseModelData(
        status: json["status"],
        message: json["message"],
        responseData: json["response_data"] == null ? [] : List<dynamic>.from(json["response_data"]!.map((x) => x)),
        errorData: json["error_data"] == null ? [] : List<dynamic>.from(json["error_data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x)),
        "error_data": errorData == null ? [] : List<dynamic>.from(errorData!.map((x) => x)),
    };
}
