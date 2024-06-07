// To parse this JSON data, do
//
//     final getVendorRequestsModel = getVendorRequestsModelFromJson(jsonString);

import 'dart:convert';

GetVendorRequestsModel getVendorRequestsModelFromJson(String str) => GetVendorRequestsModel.fromJson(json.decode(str));

String getVendorRequestsModelToJson(GetVendorRequestsModel data) => json.encode(data.toJson());

class GetVendorRequestsModel {
    final Data? data;

    GetVendorRequestsModel({
        this.data,
    });

    factory GetVendorRequestsModel.fromJson(Map<String, dynamic> json) => GetVendorRequestsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    final bool? status;
    final String? message;
    final VendorsRequestResponseData? responseData;
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
        responseData: json["response_data"] == null ? null : VendorsRequestResponseData.fromJson(json["response_data"]),
        errorData: json["error_data"] == null ? [] : List<dynamic>.from(json["error_data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData?.toJson(),
        "error_data": errorData == null ? [] : List<dynamic>.from(errorData!.map((x) => x)),
    };
}

class VendorsRequestResponseData {
    final List<dynamic>? data;
    final String? currentPage;
    final int? totalData;
    final int? totalResult;

    VendorsRequestResponseData({
        this.data,
        this.currentPage,
        this.totalData,
        this.totalResult,
    });

    factory VendorsRequestResponseData.fromJson(Map<String, dynamic> json) => VendorsRequestResponseData(
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        currentPage: json["current_page"],
        totalData: json["total_data"],
        totalResult: json["total_result"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "current_page": currentPage,
        "total_data": totalData,
        "total_result": totalResult,
    };
}
