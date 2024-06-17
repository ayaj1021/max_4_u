
class ApiResponse {
  final bool? status;
  final String? message;
  final AuditLogResponseData? responseData;
  final List<dynamic>? errorData;

  ApiResponse({
    this.status,
    this.message,
    this.responseData,
    this.errorData,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      responseData: json['response_data'] != null
          ? AuditLogResponseData.fromJson(json['response_data'])
          : null,
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

class AuditLogResponseData {
  final List<ActivityLog>? data;
  final String? currentPage;
  final int? totalData;
  final int? totalResult;

  AuditLogResponseData({
    this.data,
    this.currentPage,
    this.totalData,
    this.totalResult,
  });

  factory AuditLogResponseData.fromJson(Map<String, dynamic> json) {
    return AuditLogResponseData(
      data: json['data'] != null
          ? List<ActivityLog>.from(json['data'].map((x) => ActivityLog.fromJson(x)))
          : null,
      currentPage: json['current_page'],
      totalData: json['total_data'],
      totalResult: json['total_result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList(),
      'current_page': currentPage,
      'total_data': totalData,
      'total_result': totalResult,
    };
  }
}

class ActivityLog {
  final String? uniqueId;
  final String? lastName;
  final String? firstName;
  final String? activity;
  final String? deviceName;
  final String? deviceModel;
  final String? operatingSystem;
  final String? ipAddress;
  final String? location;
  final String? status;
  final String? regDate;

  ActivityLog({
    this.uniqueId,
    this.lastName,
    this.firstName,
    this.activity,
    this.deviceName,
    this.deviceModel,
    this.operatingSystem,
    this.ipAddress,
    this.location,
    this.status,
    this.regDate,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      uniqueId: json['unique_id'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      activity: json['activity'],
      deviceName: json['device_name'],
      deviceModel: json['device_model'],
      operatingSystem: json['operating_system'],
      ipAddress: json['ip_address'],
      location: json['location'],
      status: json['status'],
      regDate: json['reg_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'last_name': lastName,
      'first_name': firstName,
      'activity': activity,
      'device_name': deviceName,
      'device_model': deviceModel,
      'operating_system': operatingSystem,
      'ip_address': ipAddress,
      'location': location,
      'status': status,
      'reg_date': regDate,
    };
  }
}

