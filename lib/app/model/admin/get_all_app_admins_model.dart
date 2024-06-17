class DataModel {
  bool? status;
  String? message;
  AllAppAdminsResponseData? responseData;
  List<dynamic>? errorData;

  DataModel({this.status, this.message, this.responseData, this.errorData});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      status: json['data']['status'],
      message: json['data']['message'],
      responseData: json['data']['response_data'] != null
          ? AllAppAdminsResponseData.fromJson(json['data']['response_data'])
          : null,
      errorData: json['data']['error_data'] != null
          ? List<dynamic>.from(json['data']['error_data'])
          : null,
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

class AllAppAdminsResponseData {
  List<Data>? data;
  String? currentPage;
  int? totalData;
  int? totalResult;
  int? totalConsumer;
  int? totalActiveConsumer;
  int? totalInactiveConsumer;
  int? totalVendor;
  int? totalActiveVendor;
  int? totalInactiveVendor;
  int? totalAdmin;

  AllAppAdminsResponseData({
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

  factory AllAppAdminsResponseData.fromJson(Map<String, dynamic> json) {
    return AllAppAdminsResponseData(
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((item) => Data.fromJson(item)))
          : null,
      currentPage: json['current_page'],
      totalData: json['total_data'],
      totalResult: json['total_result'],
      totalConsumer: json['total_consumer'],
      totalActiveConsumer: json['total_active_consumer'],
      totalInactiveConsumer: json['total_inactive_consumer'],
      totalVendor: json['total_vendor'],
      totalActiveVendor: json['total_active_vendor'],
      totalInactiveVendor: json['total_inactive_vendor'],
      totalAdmin: json['total_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
      'current_page': currentPage,
      'total_data': totalData,
      'total_result': totalResult,
      'total_consumer': totalConsumer,
      'total_active_consumer': totalActiveConsumer,
      'total_inactive_consumer': totalInactiveConsumer,
      'total_vendor': totalVendor,
      'total_active_vendor': totalActiveVendor,
      'total_inactive_vendor': totalInactiveVendor,
      'total_admin': totalAdmin,
    };
  }
}

class Data {
  String? uniqueId;
  String? lastName;
  String? firstName;
  String? email;
  String? mobileNumber;
  String? level;
  String? status;
  String? emailStatus;
  String? regDate;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      uniqueId: json['unique_id'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      level: json['level'],
      status: json['status'],
      emailStatus: json['email_status'],
      regDate: json['reg_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'last_name': lastName,
      'first_name': firstName,
      'email': email,
      'mobile_number': mobileNumber,
      'level': level,
      'status': status,
      'email_status': emailStatus,
      'reg_date': regDate,
    };
  }
}
