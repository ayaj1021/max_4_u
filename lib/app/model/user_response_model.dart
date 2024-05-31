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
    final UserAccount? userAccount;
    final List<UserSettingsDatum>? userSettingsData;
    final List<dynamic>? beneficiaryData;
    final List<Service>? services;
    final List<Product>? products;
    final TransactionHistory? transactionHistory;
    final AutoRenewal? autoRenewal;
    final List<dynamic>? bankDetails;

    ResponseDataData({
        this.userData,
        this.userAccount,
        this.userSettingsData,
        this.beneficiaryData,
        this.services,
        this.products,
        this.transactionHistory,
        this.autoRenewal,
        this.bankDetails,
    });

    factory ResponseDataData.fromJson(Map<String, dynamic> json) => ResponseDataData(
        userData: json["user_data"] == null ? [] : List<UserDatum>.from(json["user_data"]!.map((x) => UserDatum.fromJson(x))),
        userAccount: json["user_account"] == null ? null : UserAccount.fromJson(json["user_account"]),
        userSettingsData: json["user_settings_data"] == null ? [] : List<UserSettingsDatum>.from(json["user_settings_data"]!.map((x) => UserSettingsDatum.fromJson(x))),
        beneficiaryData: json["beneficiary_data"] == null ? [] : List<dynamic>.from(json["beneficiary_data"]!.map((x) => x)),
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        transactionHistory: json["transaction_history"] == null ? null : TransactionHistory.fromJson(json["transaction_history"]),
        autoRenewal: json["auto_renewal"] == null ? null : AutoRenewal.fromJson(json["auto_renewal"]),
        bankDetails: json["bank_details"] == null ? [] : List<dynamic>.from(json["bank_details"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
        "user_account": userAccount?.toJson(),
        "user_settings_data": userSettingsData == null ? [] : List<dynamic>.from(userSettingsData!.map((x) => x.toJson())),
        "beneficiary_data": beneficiaryData == null ? [] : List<dynamic>.from(beneficiaryData!.map((x) => x)),
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "transaction_history": transactionHistory?.toJson(),
        "auto_renewal": autoRenewal?.toJson(),
        "bank_details": bankDetails == null ? [] : List<dynamic>.from(bankDetails!.map((x) => x)),
    };
} 



class TransactionHistory{
    final List<Datum>? data;
    final int? currentPage;
    final int? totalData;
    final int? totalResult;

    TransactionHistory({
        this.data,
        this.currentPage,
        this.totalData,
        this.totalResult,
    });

    factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
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


class AutoRenewal {
    final List<Datum>? data;
    final int? currentPage;
    final int? totalData;
    final int? totalResult;

    AutoRenewal({
        this.data,
        this.currentPage,
        this.totalData,
        this.totalResult,
    });

    factory AutoRenewal.fromJson(Map<String, dynamic> json) => AutoRenewal(
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
    final String? referenceId;
    final String? number;
    final String? type;
    final String? subType;
    final String? purchaseType;
    final String? productCode;
    final String? productAmount;
    final String? amountPaid;
    final String? discount;
    final String? commissionEarn;
    final String? status;
    final DateTime? regDate;
    final String? uniqueId;
    final String? lastName;
    final String? firstName;

    Datum({
        this.referenceId,
        this.number,
        this.type,
        this.subType,
        this.purchaseType,
        this.productCode,
        this.productAmount,
        this.amountPaid,
        this.discount,
        this.commissionEarn,
        this.status,
        this.regDate,
        this.uniqueId,
        this.lastName,
        this.firstName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        referenceId: json["reference_id"],
        number: json["number"],
        type: json["type"],
        subType: json["sub_type"],
        purchaseType: json["purchase_type"],
        productCode: json["product_code"],
        productAmount: json["product_amount"],
        amountPaid: json["amount_paid"],
        discount: json["discount"],
        commissionEarn: json["commission_earn"],
        status: json["status"],
        regDate: json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
        uniqueId: json["unique_id"],
        lastName: json["last_name"],
        firstName: json["first_name"],
    );

    Map<String, dynamic> toJson() => {
        "reference_id": referenceId,
        "number": number,
        "type": type,
        "sub_type": subType,
        "purchase_type": purchaseType,
        "product_code": productCode,
        "product_amount": productAmount,
        "amount_paid": amountPaid,
        "discount": discount,
        "commission_earn": commissionEarn,
        "status": status,
        "reg_date": regDate?.toIso8601String(),
        "unique_id": uniqueId,
        "last_name": lastName,
        "first_name": firstName,
    };
}

class Product {
    final String? name;
    final String? code;
    final String? serviceName;
    final String? category;
    final String? price;
    final String? consumerDiscount;
    final String? vendorDiscount;
    final String? serviceFee;
    final String? logo;
    final String? duration;
    final String? status;

    Product({
        this.name,
        this.code,
        this.serviceName,
        this.category,
        this.price,
        this.consumerDiscount,
        this.vendorDiscount,
        this.serviceFee,
        this.logo,
        this.duration,
        this.status,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        code: json["code"],
        serviceName: json["service_name"],
        category: json["category"],
        price: json["price"],
        consumerDiscount: json["consumer_discount"],
        vendorDiscount: json["vendor_discount"],
        serviceFee: json["service_fee"],
        logo: json["logo"],
        duration: json["duration"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "service_name": serviceName,
        "category": category,
        "price": price,
        "consumer_discount": consumerDiscount,
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

class UserAccount {
    final int? balance;

    UserAccount({
        this.balance,
    });

    factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
    };
}

class UserDatum {
    final String? uniqueId;
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? mobileNumber;
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
