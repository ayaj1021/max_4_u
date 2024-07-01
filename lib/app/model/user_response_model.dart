// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class ResponseModel {
  final bool? status;
  final String? message;
  final ResponseDataData? responseData;
  final List<dynamic>? errorData;

  ResponseModel({this.status, this.message, this.responseData, this.errorData});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      responseData: json['response_data'] != null ? ResponseDataData.fromJson(json['response_data']) : null,
      errorData: json['error_data'] as List<dynamic>?,
    );
  }
}

class ResponseDataData {
  final List<UserData>? userData;
  final UserAccount? userAccount;
  final List<UserSettingsData>? userSettingsData;
  final List<dynamic>? beneficiaryData;
  final List<Service>? services;
  final List<Product>? products;
  final TransactionHistory? transactionHistory;
  final AutoRenewal? autoRenewal;
  final SiteData? siteData;
  final List<SubService>? subServices;
  final List<dynamic>? vendingCode;

  ResponseDataData({
    this.userData,
    this.userAccount,
    this.userSettingsData,
    this.beneficiaryData,
    this.services,
    this.products,
    this.transactionHistory,
    this.autoRenewal,
    this.siteData,
    this.subServices,
    this.vendingCode,
  });

  factory ResponseDataData.fromJson(Map<String, dynamic> json) {
    return ResponseDataData(
      userData: (json['user_data'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      userAccount: json['user_account'] != null ? UserAccount.fromJson(json['user_account']) : null,
      userSettingsData: (json['user_settings_data'] as List<dynamic>?)
          ?.map((e) => UserSettingsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      beneficiaryData: json['beneficiary_data'] as List<dynamic>?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactionHistory: json['transaction_history'] != null
          ? TransactionHistory.fromJson(json['transaction_history'])
          : null,
      autoRenewal: json['auto_renewal'] != null ? AutoRenewal.fromJson(json['auto_renewal']) : null,
      siteData: json['site_data'] != null ? SiteData.fromJson(json['site_data']) : null,
      subServices: (json['sub_services'] as List<dynamic>?)
          ?.map((e) => SubService.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendingCode: json['vending_code'] as List<dynamic>?,
    );
  }
}

class UserData {
  final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? level;
  final String? status;
  final String? emailStatus;
  final String? regDate;

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uniqueId: json['unique_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      level: json['level'] as String?,
      status: json['status'] as String?,
      emailStatus: json['email_status'] as String?,
      regDate: json['reg_date'] as String?,
    );
  }
}

class UserAccount {
  final int? balance;

  UserAccount({this.balance});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      balance: json['balance'] as int?,
    );
  }
}

class UserSettingsData {
  final String? sms;
  final String? email;
  final String? pushNotification;

  UserSettingsData({this.sms, this.email, this.pushNotification});

  factory UserSettingsData.fromJson(Map<String, dynamic> json) {
    return UserSettingsData(
      sms: json['sms'] as String?,
      email: json['email'] as String?,
      pushNotification: json['push_notification'] as String?,
    );
  }
}

class Service {
  final String? category;

  Service({this.category});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      category: json['category'] as String?,
    );
  }
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String?,
      code: json['code'] as String?,
      serviceName: json['service_name'] as String?,
      category: json['category'] as String?,
      price: json['price'] as String?,
      consumerDiscount: json['consumer_discount'] as String?,
      vendorDiscount: json['vendor_discount'] as String?,
      serviceFee: json['service_fee'] as String?,
      logo: json['logo'] as String?,
      duration: json['duration'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'serviceName': serviceName,
      'category': category,
      'price': price,
      'consumerDiscount': consumerDiscount,
      'vendorDiscount': vendorDiscount,
      'serviceFee': serviceFee,
      'logo': logo,
      'duration': duration,
      'status': status,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      serviceName: map['serviceName'] != null ? map['serviceName'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      consumerDiscount: map['consumerDiscount'] != null ? map['consumerDiscount'] as String : null,
      vendorDiscount: map['vendorDiscount'] != null ? map['vendorDiscount'] as String : null,
      serviceFee: map['serviceFee'] != null ? map['serviceFee'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TransactionHistory {
  final List<Transaction>? data;
  final int? currentPage;
  final int? totalData;
  final int? totalResult;

  TransactionHistory({
    this.data,
    this.currentPage,
    this.totalData,
    this.totalResult,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int?,
      totalData: json['total_data'] as int?,
      totalResult: json['total_result'] as int?,
    );
  }
}

class Transaction {
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
  final String? regDate;
  final String? uniqueId;
  final String? lastName;
  final String? firstName;
  final String? level;

  Transaction({
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
    this.level,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      referenceId: json['reference_id'] as String?,
      number: json['number'] as String?,
      type: json['type'] as String?,
      subType: json['sub_type'] as String?,
      purchaseType: json['purchase_type'] as String?,
      productCode: json['product_code'] as String?,
      productAmount: json['product_amount'] as String?,
      amountPaid: json['amount_paid'] as String?,
      discount: json['discount'] as String?,
      commissionEarn: json['commission_earn'] as String?,
      status: json['status'] as String?,
      regDate: json['reg_date'] as String?,
      uniqueId: json['unique_id'] as String?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      level: json['level'] as String?,
    );
  }
}

class AutoRenewal {
  final List<dynamic>? data;
  final int? currentPage;
  final int? totalData;
  final int? totalResult;

  AutoRenewal({this.data, this.currentPage, this.totalData, this.totalResult});

  factory AutoRenewal.fromJson(Map<String, dynamic> json) {
    return AutoRenewal(
      data: json['data'] as List<dynamic>?,
      currentPage: json['current_page'] as int?,
      totalData: json['total_data'] as int?,
      totalResult: json['total_result'] as int?,
    );
  }
}
class SiteData {
  final String? idCardUrl;
  final String? userImageUrl;

  SiteData({this.idCardUrl, this.userImageUrl});

  factory SiteData.fromJson(Map<String, dynamic> json) {
    return SiteData(
      idCardUrl: json['id_card_url'] as String?,
      userImageUrl: json['user_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_card_url': idCardUrl,
      'user_image_url': userImageUrl,
    };
  }
}
class SubService {
  final String? category;

  SubService({this.category});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      category: json['category'] as String?,
    );
  }
}
