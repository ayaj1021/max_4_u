// To parse this JSON data, do
//
//     final dataPlans = dataPlansFromJson(jsonString);

import 'dart:convert';

DataPlans dataPlansFromJson(String str) => DataPlans.fromJson(json.decode(str));

String dataPlansToJson(DataPlans data) => json.encode(data.toJson());

class DataPlans {
  Data data;

  DataPlans({
    required this.data,
  });

  factory DataPlans.fromJson(Map<String, dynamic> json) => DataPlans(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  List<UserDatum> userData;
  UserAccount userAccount;
  List<dynamic> userSettingsData;
  List<BeneficiaryDatum> beneficiaryData;
  List<Service> services;
  List<Product> products;
  // TransactionHistory transactionHistory;
  AutoRenewal autoRenewal;
  List<dynamic> myVendor;
  VerificationStatus verificationStatus;
  bool status;

  Data({
    required this.userData,
    required this.userAccount,
    required this.userSettingsData,
    required this.beneficiaryData,
    required this.services,
    required this.products,
    // required this.transactionHistory,
    required this.autoRenewal,
    required this.myVendor,
    required this.verificationStatus,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: List<UserDatum>.from(json["user_data"].map((x) => UserDatum.fromJson(x))),
        userAccount: UserAccount.fromJson(json["user_account"]),
        userSettingsData: List<dynamic>.from(json["user_settings_data"].map((x) => x)),
        beneficiaryData: List<BeneficiaryDatum>.from(json["beneficiary_data"].map((x) => BeneficiaryDatum.fromJson(x))),
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        // transactionHistory: TransactionHistory.fromJson(json["transaction_history"]),
        autoRenewal: AutoRenewal.fromJson(json["auto_renewal"]),
        myVendor: List<dynamic>.from(json["my_vendor"].map((x) => x)),
        verificationStatus: VerificationStatus.fromJson(json["verification_status"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_data": List<dynamic>.from(userData.map((x) => x.toJson())),
        "user_account": userAccount.toJson(),
        "user_settings_data": List<dynamic>.from(userSettingsData.map((x) => x)),
        "beneficiary_data": List<dynamic>.from(beneficiaryData.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        // "transaction_history": transactionHistory.toJson(),
        "auto_renewal": autoRenewal.toJson(),
        "my_vendor": List<dynamic>.from(myVendor.map((x) => x)),
        "verification_status": verificationStatus.toJson(),
        "status": status,
      };
}

class AutoRenewal {
  List<Datum> data;
  int currentPage;
  int totalData;
  int totalResult;

  AutoRenewal({
    required this.data,
    required this.currentPage,
    required this.totalData,
    required this.totalResult,
  });

  factory AutoRenewal.fromJson(Map<String, dynamic> json) => AutoRenewal(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        currentPage: json["current_page"],
        totalData: json["total_data"],
        totalResult: json["total_result"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "current_page": currentPage,
        "total_data": totalData,
        "total_result": totalResult,
      };
}

class Datum {
  int id;
  String number;
  String productCode;
  Category category;
  Logo serviceName;
  String amount;
  String subInterval;
  DateTime regDate;
  DateTime nextPurchase;
  DateTime endDate;
  int userId;
  dynamic vendorId;
  int setBy;

  Datum({
    required this.id,
    required this.number,
    required this.productCode,
    required this.category,
    required this.serviceName,
    required this.amount,
    required this.subInterval,
    required this.regDate,
    required this.nextPurchase,
    required this.endDate,
    required this.userId,
    required this.vendorId,
    required this.setBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        number: json["number"],
        productCode: json["product_code"],
        category: categoryValues.map[json["category"]]!,
        serviceName: logoValues.map[json["service_name"]]!,
        amount: json["amount"],
        subInterval: json["sub_interval"],
        regDate: DateTime.parse(json["reg_date"]),
        nextPurchase: DateTime.parse(json["next_purchase"]),
        endDate: DateTime.parse(json["end_date"]),
        userId: json["user_id"],
        vendorId: json["vendor_id"],
        setBy: json["set_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "product_code": productCode,
        "category": categoryValues.reverse[category],
        "service_name": logoValues.reverse[serviceName],
        "amount": amount,
        "sub_interval": subInterval,
        "reg_date": regDate.toIso8601String(),
        "next_purchase": nextPurchase.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "user_id": userId,
        "vendor_id": vendorId,
        "set_by": setBy,
      };
}

enum Category { AIRTIME, DATA }

final categoryValues = EnumValues({"airtime": Category.AIRTIME, "data": Category.DATA});

enum Logo { AIRTEL, GLO, MTN, THE_9_MOBILE }

final logoValues = EnumValues({"airtel": Logo.AIRTEL, "glo": Logo.GLO, "mtn": Logo.MTN, "9mobile": Logo.THE_9_MOBILE});

class BeneficiaryDatum {
  String phone;
  String name;

  BeneficiaryDatum({
    required this.phone,
    required this.name,
  });

  factory BeneficiaryDatum.fromJson(Map<String, dynamic> json) => BeneficiaryDatum(
        phone: json["phone"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
      };
}

class Product {
  String name;
  String code;
  Logo serviceName;
  Category category;
  String price;
  String consumerDiscount;
  String vendorDiscount;
  String serviceFee;
  Logo logo;
  String duration;
  Status status;

  Product({
    required this.name,
    required this.code,
    required this.serviceName,
    required this.category,
    required this.price,
    required this.consumerDiscount,
    required this.vendorDiscount,
    required this.serviceFee,
    required this.logo,
    required this.duration,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        code: json["code"],
        serviceName: logoValues.map[json["service_name"]]!,
        category: categoryValues.map[json["category"]]!,
        price: json["price"],
        consumerDiscount: json["consumer_discount"],
        vendorDiscount: json["vendor_discount"],
        serviceFee: json["service_fee"],
        logo: logoValues.map[json["logo"]]!,
        duration: json["duration"],
        status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "service_name": logoValues.reverse[serviceName],
        "category": categoryValues.reverse[category],
        "price": price,
        "consumer_discount": consumerDiscount,
        "vendor_discount": vendorDiscount,
        "service_fee": serviceFee,
        "logo": logoValues.reverse[logo],
        "duration": duration,
        "status": statusValues.reverse[status],
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"active": Status.ACTIVE});

class Service {
  Category category;

  Service({
    required this.category,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        category: categoryValues.map[json["category"]]!,
      );

  Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
      };
}

// class TransactionHistory {
//   List<Map<String, String?>> data;
//   int currentPage;
//   int totalData;
//   ResponseData responseData;
//
//   TransactionHistory({
//     required this.data,
//     required this.currentPage,
//     required this.totalData,
//     required this.responseData,
//   });
//
//   factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
//         data: List<Map<String, String?>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
//         currentPage: json["current_page"],
//         totalData: json["total_data"],
//         responseData: ResponseData.fromJson(json["response_data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "current_page": currentPage,
//         "total_data": totalData,
//         "response_data": responseData.toJson(),
//       };
// }

class ResponseData {
  int totalResult;

  ResponseData({
    required this.totalResult,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        totalResult: json["total_result"],
      );

  Map<String, dynamic> toJson() => {
        "total_result": totalResult,
      };
}

class UserAccount {
  int balance;

  UserAccount({
    required this.balance,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
      };
}

class UserDatum {
  String uniqueId;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String level;
  Status status;
  String emailStatus;
  DateTime regDate;

  UserDatum({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.level,
    required this.status,
    required this.emailStatus,
    required this.regDate,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        uniqueId: json["unique_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        level: json["level"],
        status: statusValues.map[json["status"]]!,
        emailStatus: json["email_status"],
        regDate: DateTime.parse(json["reg_date"]),
      );

  Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "level": level,
        "status": statusValues.reverse[status],
        "email_status": emailStatus,
        "reg_date": regDate.toIso8601String(),
      };
}

class VerificationStatus {
  String bvn;
  String nin;
  String ninImageLink;
  String vendorImageLink;
  String status;

  VerificationStatus({
    required this.bvn,
    required this.nin,
    required this.ninImageLink,
    required this.vendorImageLink,
    required this.status,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
