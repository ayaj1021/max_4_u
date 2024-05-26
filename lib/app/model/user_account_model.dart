//

class ResponseData {
  bool? status;
  String? message;
  ResponseData? responseData;

  ResponseData({
    this.status,
    this.message,
    this.responseData,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responseData = json['response_data'] != null
        ? ResponseData.fromJson(json['response_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (responseData != null) {
      data['response_data'] = responseData!.toJson();
    }
    return data;
  }
}

class DataResponse {
  List<UserData>? userData;
  List<UserSettingsData>? userSettingsData;
  List<dynamic>? beneficiaryData;
  List<Service>? services;
  List<Product>? products;

  DataResponse({
    this.userData,
    this.userSettingsData,
    this.beneficiaryData,
    this.services,
    this.products,
  });

  DataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      userData = <UserData>[];
      json['data']['user_data'].forEach((v) {
        userData!.add(UserData.fromJson(v));
      });
      userSettingsData = <UserSettingsData>[];
      json['data']['user_settings_data'].forEach((v) {
        userSettingsData!.add(UserSettingsData.fromJson(v));
      });
      beneficiaryData = json['data']['beneficiary_data'].cast<dynamic>();
      services = <Service>[];
      json['data']['services'].forEach((v) {
        services!.add(Service.fromJson(v));
      });
      products = <Product>[];
      json['data']['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['user_data'] = userData!.map((v) => v.toJson()).toList();
    }
    if (userSettingsData != null) {
      data['user_settings_data'] =
          userSettingsData!.map((v) => v.toJson()).toList();
    }
    if (beneficiaryData != null) {
      data['beneficiary_data'] = beneficiaryData;
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? balance;
  final String? level;
  final String? status;
  final String? emailStatus;
  final DateTime? regDate;

  UserData({
    this.uniqueId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.balance,
    this.level,
    this.status,
    this.emailStatus,
    this.regDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uniqueId: json['unique_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      balance: json['balance'].toString(),
      level: json['level'].toString(),
      status: json['status'],
      emailStatus: json['email_status'],
      regDate: DateTime.tryParse(json['reg_date']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['balance'] = balance;
    data['level'] = level;
    data['status'] = status;
    data['email_status'] = emailStatus;
    data['reg_date'] = regDate?.toIso8601String();
    return data;
  }
}

class UserSettingsData {
  String? sms;
  String? email;
  String? pushNotification;

  UserSettingsData({
    this.sms,
    this.email,
    this.pushNotification,
  });

  UserSettingsData.fromJson(Map<String, dynamic> json) {
    sms = json['sms'];
    email = json['email'];
    pushNotification = json['push_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sms'] = sms;
    data['email'] = email;
    data['push_notification'] = pushNotification;
    return data;
  }
}

class Service {
  String? category;

  Service({this.category});

  Service.fromJson(Map<String, dynamic> json) {
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    return data;
  }
}

class Product {
  final int? id;
  final String? name;
  final String? code;
  final String? serviceName;
  final String? category;
  final String? price;
  final String? consumerCommission;
  final String? consumerDiscount;
  final String? vendorCommission;
  final String? vendorDiscount;
  final String? serviceFee;
  final String? logo;
  final String? duration;
  final String? status;

  Product({
    this.id,
    this.name,
    this.code,
    this.serviceName,
    this.category,
    this.price,
    this.consumerCommission,
    this.consumerDiscount,
    this.vendorCommission,
    this.vendorDiscount,
    this.serviceFee,
    this.logo,
    this.duration,
    this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      serviceName: json['service_name'],
      category: json['category'],
      price: json['price'].toString(),
      consumerCommission: json['consumer_commission'].toString(),
      consumerDiscount: json['consumer_discount'].toString(),
      vendorCommission: json['vendor_commission'].toString(),
      vendorDiscount: json['vendor_discount'].toString(),
      serviceFee: json['service_fee'].toString(),
      logo: json['logo'],
      duration: json['duration'].toString(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['service_name'] = serviceName;
    data['category'] = category;
    data['price'] = price;
    data['consumer_commission'] = consumerCommission;
    data['consumer_discount'] = consumerDiscount;
    data['vendor_commission'] = vendorCommission;
    data['vendor_discount'] = vendorDiscount;
    data['service_fee'] = serviceFee;
    data['logo'] = logo;
    data['duration'] = duration;
    data['status'] = status;
    return data;
  }
}
