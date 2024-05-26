// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
    final ResponseModelData? data;

    ResponseModel({
        this.data,
    });

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        data: json["data"] == null ? null : ResponseModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class ResponseModelData {
    final bool? status;
    final String? message;
    final ResponseData? responseData;
    final List<dynamic>? errorData;

    ResponseModelData({
        this.status,
        this.message,
        this.responseData,
        this.errorData,
    });

    factory ResponseModelData.fromJson(Map<String, dynamic> json) => ResponseModelData(
        status: json["status"],
        message: json["message"],
        responseData: json["response_data"] == null ? null : ResponseData.fromJson(json["response_data"]),
        errorData: json["error_data"] == null ? [] : List<dynamic>.from(json["error_data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData?.toJson(),
        "error_data": errorData == null ? [] : List<dynamic>.from(errorData!.map((x) => x)),
    };
}

class ResponseData {
    final ResponseDataData? data;

    ResponseData({
        this.data,
    });

    factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        data: json["data"] == null ? null : ResponseDataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class ResponseDataData {
    final List<UserDatum>? userData;
    final List<UserSettingsDatum>? userSettingsData;
    final List<dynamic>? beneficiaryData;
    final List<Service>? services;
    final List<Product>? products;
    final List<dynamic>? transactionHistory;
    final List<dynamic>? autoRenewal;
    final List<dynamic>? myVendor;
    final VerificationStatus? verificationStatus;

    ResponseDataData({
        this.userData,
        this.userSettingsData,
        this.beneficiaryData,
        this.services,
        this.products,
        this.transactionHistory,
        this.autoRenewal,
        this.myVendor,
        this.verificationStatus,
    });

    factory ResponseDataData.fromJson(Map<String, dynamic> json) => ResponseDataData(
        userData: json["user_data"] == null ? [] : List<UserDatum>.from(json["user_data"]!.map((x) => UserDatum.fromJson(x))),
        userSettingsData: json["user_settings_data"] == null ? [] : List<UserSettingsDatum>.from(json["user_settings_data"]!.map((x) => UserSettingsDatum.fromJson(x))),
        beneficiaryData: json["beneficiary_data"] == null ? [] : List<dynamic>.from(json["beneficiary_data"]!.map((x) => x)),
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        transactionHistory: json["transaction_history"] == null ? [] : List<dynamic>.from(json["transaction_history"]!.map((x) => x)),
        autoRenewal: json["auto_renewal"] == null ? [] : List<dynamic>.from(json["auto_renewal"]!.map((x) => x)),
        myVendor: json["my_vendor"] == null ? [] : List<dynamic>.from(json["my_vendor"]!.map((x) => x)),
        verificationStatus: json["verification_status"] == null ? null : VerificationStatus.fromJson(json["verification_status"]),
    );

    Map<String, dynamic> toJson() => {
        "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
        "user_settings_data": userSettingsData == null ? [] : List<dynamic>.from(userSettingsData!.map((x) => x.toJson())),
        "beneficiary_data": beneficiaryData == null ? [] : List<dynamic>.from(beneficiaryData!.map((x) => x)),
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "transaction_history": transactionHistory == null ? [] : List<dynamic>.from(transactionHistory!.map((x) => x)),
        "auto_renewal": autoRenewal == null ? [] : List<dynamic>.from(autoRenewal!.map((x) => x)),
        "my_vendor": myVendor == null ? [] : List<dynamic>.from(myVendor!.map((x) => x)),
        "verification_status": verificationStatus?.toJson(),
    };
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

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        serviceName: json["service_name"],
        category: json["category"],
        price: json["price"],
        consumerCommission: json["consumer_commission"],
        consumerDiscount: json["consumer_discount"],
        vendorCommission: json["vendor_commission"],
        vendorDiscount: json["vendor_discount"],
        serviceFee: json["service_fee"],
        logo: json["logo"],
        duration: json["duration"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "service_name": serviceName,
        "category": category,
        "price": price,
        "consumer_commission": consumerCommission,
        "consumer_discount": consumerDiscount,
        "vendor_commission": vendorCommission,
        "vendor_discount": vendorDiscount,
        "service_fee": serviceFee,
        "logo": logo,
        "duration": duration,
        "status": status,
    };
}

class Service {
    final String? category;

    Service({
        this.category,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
    };
}

class UserDatum {
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

    UserDatum({
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

    factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        uniqueId: json["unique_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        balance: json["balance"],
        level: json["level"],
        status: json["status"],
        emailStatus: json["email_status"],
        regDate: json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
    );

    Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "balance": balance,
        "level": level,
        "status": status,
        "email_status": emailStatus,
        "reg_date": regDate?.toIso8601String(),
    };
}

class UserSettingsDatum {
    final String? sms;
    final String? email;
    final String? pushNotification;

    UserSettingsDatum({
        this.sms,
        this.email,
        this.pushNotification,
    });

    factory UserSettingsDatum.fromJson(Map<String, dynamic> json) => UserSettingsDatum(
        sms: json["sms"],
        email: json["email"],
        pushNotification: json["push_notification"],
    );

    Map<String, dynamic> toJson() => {
        "sms": sms,
        "email": email,
        "push_notification": pushNotification,
    };
}

class VerificationStatus {
    final String? bvn;
    final String? nin;
    final String? ninImageLink;
    final String? vendorImageLink;
    final String? status;

    VerificationStatus({
        this.bvn,
        this.nin,
        this.ninImageLink,
        this.vendorImageLink,
        this.status,
    });

    factory VerificationStatus.fromJson(Map<String, dynamic> json) => VerificationStatus(
        bvn: json["bvn"],
        nin: json["nin"],
        ninImageLink: json["nin_image_link"],
        vendorImageLink: json["vendor_image_link"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "bvn": bvn,
        "nin": nin,
        "nin_image_link": ninImageLink,
        "vendor_image_link": vendorImageLink,
        "status": status,
    };
}
