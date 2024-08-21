
class ApiResponse {
  bool? status;
  String? message;
  VendorRequestResponseData? responseData;
  List<dynamic>? errorData;

  ApiResponse({
    this.status,
    this.message,
    this.responseData,
    this.errorData,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      responseData: json['response_data'] != null ? VendorRequestResponseData.fromJson(json['response_data']) : null,
      errorData: json['error_data'] != null ? List<dynamic>.from(json['error_data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'response_data': responseData?.toJson(),
      'error_data': errorData,
    };
  }
}

class VendorRequestResponseData {
  List<UserData>? data;
  String? currentPage;
  int? totalData;
  int? totalResult;
  int? totalIncomplete;
  int? totalPending;
  int? totalConfirmed;
  int? totalDenied;

  VendorRequestResponseData({
    this.data,
    this.currentPage,
    this.totalData,
    this.totalResult,
    this.totalIncomplete,
    this.totalPending,
    this.totalConfirmed,
    this.totalDenied,
  });

  factory VendorRequestResponseData.fromJson(Map<String, dynamic> json) {
    return VendorRequestResponseData(
      data: json['data'] != null ? List<UserData>.from(json['data'].map((x) => UserData.fromJson(x))) : null,
      currentPage: json['current_page'] as String?,
      totalData: json['total_data'] as int?,
      totalResult: json['total_result'] as int?,
      totalIncomplete: json['total_incomplete'] as int?,
      totalPending: json['total_pending'] as int?,
      totalConfirmed: json['total_confirmed'] as int?,
      totalDenied: json['total_denied'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList(),
      'current_page': currentPage,
      'total_data': totalData,
      'total_result': totalResult,
      'total_incomplete': totalIncomplete,
      'total_pending': totalPending,
      'total_confirmed': totalConfirmed,
    };
  }
}

class UserData {
  String? uniqueId;
  String? lastName;
  String? firstName;
  String? bvn;
  String? nin;
  String? ninImageLink;
  String? vendorImageLink;
  String? status;
  String? regDate;

  UserData({
    this.uniqueId,
    this.lastName,
    this.firstName,
    this.bvn,
    this.nin,
    this.ninImageLink,
    this.vendorImageLink,
    this.status,
    this.regDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uniqueId: json['unique_id'] as String?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      bvn: json['bvn'] as String?,
      nin: json['nin'] as String?,
      ninImageLink: json['nin_image_link'] as String?,
      vendorImageLink: json['vendor_image_link'] as String?,
      status: json['status'] as String?,
      regDate: json['reg_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'last_name': lastName,
      'first_name': firstName,
      'bvn': bvn,
      'nin': nin,
      'nin_image_link': ninImageLink,
      'vendor_image_link': vendorImageLink,
      'status': status,
      'reg_date': regDate,
    };
  }
}
