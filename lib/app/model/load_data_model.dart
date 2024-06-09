// To parse this JSON data, do
//
//     final loadDataModel = loadDataModelFromJson(jsonString);

import 'dart:convert';

LoadDataModel loadDataModelFromJson(String str) => LoadDataModel.fromJson(json.decode(str));

String loadDataModelToJson(LoadDataModel data) => json.encode(data.toJson());

class LoadDataModel {
    final LoadDataModelData? data;

    LoadDataModel({
        this.data,
    });

    factory LoadDataModel.fromJson(Map<String, dynamic> json) => LoadDataModel(
        data: json["data"] == null ? null : LoadDataModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class LoadDataModelData {
    final LoadDataData? data;
    final bool? status;

    LoadDataModelData({
        this.data,
        this.status,
    });

    factory LoadDataModelData.fromJson(Map<String, dynamic> json) => LoadDataModelData(
        data: json["data"] == null ? null : LoadDataData.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
    };
}

class LoadDataData {
    final List<UserDatum>? userData;
    final UserAccount? userAccount;
    final List<UserSettingsDatum>? userSettingsData;
    final List<BeneficiaryDatum>? beneficiaryData;
    final List<Service>? services;
    final List<Product>? products;
    final AutoRenewal? transactionHistory;
    final AutoRenewal? autoRenewal;
    final SiteData? siteData;
    final List<SubService>? subServices;

    LoadDataData({
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
    });

    factory LoadDataData.fromJson(Map<String, dynamic> json) => LoadDataData(
        userData: json["user_data"] == null ? [] : List<UserDatum>.from(json["user_data"]!.map((x) => UserDatum.fromJson(x))),
        userAccount: json["user_account"] == null ? null : UserAccount.fromJson(json["user_account"]),
        userSettingsData: json["user_settings_data"] == null ? [] : List<UserSettingsDatum>.from(json["user_settings_data"]!.map((x) => UserSettingsDatum.fromJson(x))),
        beneficiaryData: json["beneficiary_data"] == null ? [] : List<BeneficiaryDatum>.from(json["beneficiary_data"]!.map((x) => BeneficiaryDatum.fromJson(x))),
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        transactionHistory: json["transaction_history"] == null ? null : AutoRenewal.fromJson(json["transaction_history"]),
        autoRenewal: json["auto_renewal"] == null ? null : AutoRenewal.fromJson(json["auto_renewal"]),
        siteData: json["site_data"] == null ? null : SiteData.fromJson(json["site_data"]),
        subServices: json["sub_services"] == null ? [] : List<SubService>.from(json["sub_services"]!.map((x) => SubService.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
        "user_account": userAccount?.toJson(),
        "user_settings_data": userSettingsData == null ? [] : List<dynamic>.from(userSettingsData!.map((x) => x.toJson())),
        "beneficiary_data": beneficiaryData == null ? [] : List<dynamic>.from(beneficiaryData!.map((x) => x.toJson())),
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "transaction_history": transactionHistory?.toJson(),
        "auto_renewal": autoRenewal?.toJson(),
        "site_data": siteData?.toJson(),
        "sub_services": subServices == null ? [] : List<dynamic>.from(subServices!.map((x) => x.toJson())),
    };
}

class AutoRenewal {
    final List<TransactionHistory>? data;
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
        data: json["data"] == null ? [] : List<TransactionHistory>.from(json["data"]!.map((x) => TransactionHistory.fromJson(x))),
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

class TransactionHistory {
    final String? referenceId;
    final dynamic number;
    final Type? type;
    final SubType? subType;
    final PurchaseType? purchaseType;
    final dynamic productCode;
    final dynamic productAmount;
    final String? amountPaid;
    final String? discount;
    final String? commissionEarn;
    final DatumStatus? status;
    final DateTime? regDate;
    final UniqueId? uniqueId;
    final LastName? lastName;
    final FirstName? firstName;
    final String? level;

    TransactionHistory({
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

    factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
        referenceId: json["reference_id"],
        number: json["number"],
        type: typeValues.map[json["type"]]!,
        subType: subTypeValues.map[json["sub_type"]]!,
        purchaseType: purchaseTypeValues.map[json["purchase_type"]]!,
        productCode: json["product_code"],
        productAmount: json["product_amount"],
        amountPaid: json["amount_paid"],
        discount: json["discount"],
        commissionEarn: json["commission_earn"],
        status: datumStatusValues.map[json["status"]]!,
        regDate: json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
        uniqueId: uniqueIdValues.map[json["unique_id"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        firstName: firstNameValues.map[json["first_name"]]!,
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "reference_id": referenceId,
        "number": number,
        "type": typeValues.reverse[type],
        "sub_type": subTypeValues.reverse[subType],
        "purchase_type": purchaseTypeValues.reverse[purchaseType],
        "product_code": productCode,
        "product_amount": productAmount,
        "amount_paid": amountPaid,
        "discount": discount,
        "commission_earn": commissionEarn,
        "status": datumStatusValues.reverse[status],
        "reg_date": regDate?.toIso8601String(),
        "unique_id": uniqueIdValues.reverse[uniqueId],
        "last_name": lastNameValues.reverse[lastName],
        "first_name": firstNameValues.reverse[firstName],
        "level": level,
    };
}

enum FirstName {
    M_P_FQQK_QKTU_QYQ_TBQMT_YN_HW
}

final firstNameValues = EnumValues({
    "mPFqqkQktuQYQTbqmtYnHw==": FirstName.M_P_FQQK_QKTU_QYQ_TBQMT_YN_HW
});

enum LastName {
    WST_LX0_CJV8_NU8_XUS3_R_BX_VG
}

final lastNameValues = EnumValues({
    "WstLx0cjv8NU8xus3rBxVg==": LastName.WST_LX0_CJV8_NU8_XUS3_R_BX_VG
});

enum PurchaseType {
    ONE_TIME
}

final purchaseTypeValues = EnumValues({
    "one_time": PurchaseType.ONE_TIME
});

enum DatumStatus {
    PENDING
}

final datumStatusValues = EnumValues({
    "pending": DatumStatus.PENDING
});

enum SubType {
    CARD
}

final subTypeValues = EnumValues({
    "card": SubType.CARD
});

enum Type {
    FUNDING
}

final typeValues = EnumValues({
    "funding": Type.FUNDING
});

enum UniqueId {
    KYUS_DX_S9_I_IF_QNR_XFX_L5_QG
}

final uniqueIdValues = EnumValues({
    "KYUSDxS9IIfQnrXfx+L5Qg==": UniqueId.KYUS_DX_S9_I_IF_QNR_XFX_L5_QG
});

class BeneficiaryDatum {
    final String? phone;

    BeneficiaryDatum({
        this.phone,
    });

    factory BeneficiaryDatum.fromJson(Map<String, dynamic> json) => BeneficiaryDatum(
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
    };
}

class Product {
    final String? name;
    final String? code;
    final String? serviceName;
    final Category? category;
    final String? price;
    final String? consumerDiscount;
    final String? vendorDiscount;
    final String? serviceFee;
    final String? logo;
    final String? duration;
    final ProductStatus? status;

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
        category: categoryValues.map[json["category"]]!,
        price: json["price"],
        consumerDiscount: json["consumer_discount"],
        vendorDiscount: json["vendor_discount"],
        serviceFee: json["service_fee"],
        logo: json["logo"],
        duration: json["duration"],
        status: productStatusValues.map[json["status"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "service_name": serviceName,
        "category": categoryValues.reverse[category],
        "price": price,
        "consumer_discount": consumerDiscount,
        "vendor_discount": vendorDiscount,
        "service_fee": serviceFee,
        "logo": logo,
        "duration": duration,
        "status": productStatusValues.reverse[status],
    };
}

enum Category {
    AIRTIME,
    DATA
}

final categoryValues = EnumValues({
    "airtime": Category.AIRTIME,
    "data": Category.DATA
});

enum ProductStatus {
    ACTIVE
}

final productStatusValues = EnumValues({
    "active": ProductStatus.ACTIVE
});

class Service {
    final Category? category;

    Service({
        this.category,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        category: categoryValues.map[json["category"]]!,
    );

    Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
    };
}

class SiteData {
    final String? idCardUrl;
    final String? userImageUrl;

    SiteData({
        this.idCardUrl,
        this.userImageUrl,
    });

    factory SiteData.fromJson(Map<String, dynamic> json) => SiteData(
        idCardUrl: json["id_card_url"],
        userImageUrl: json["user_image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id_card_url": idCardUrl,
        "user_image_url": userImageUrl,
    };
}

class SubService {
    final int? id;
    final String? name;
    final String? code;
    final Category? category;
    final ProductStatus? status;

    SubService({
        this.id,
        this.name,
        this.code,
        this.category,
        this.status,
    });

    factory SubService.fromJson(Map<String, dynamic> json) => SubService(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        category: categoryValues.map[json["category"]]!,
        status: productStatusValues.map[json["status"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "category": categoryValues.reverse[category],
        "status": productStatusValues.reverse[status],
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
    final UniqueId? uniqueId;
    final FirstName? firstName;
    final LastName? lastName;
    final String? email;
    final String? mobileNumber;
    final String? level;
    final ProductStatus? status;
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
        uniqueId: uniqueIdValues.map[json["unique_id"]]!,
        firstName: firstNameValues.map[json["first_name"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        email: json["email"],
        mobileNumber: json["mobile_number"],
        level: json["level"],
        status: productStatusValues.map[json["status"]]!,
        emailStatus: json["email_status"],
        regDate: json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
    );

    Map<String, dynamic> toJson() => {
        "unique_id": uniqueIdValues.reverse[uniqueId],
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "email": email,
        "mobile_number": mobileNumber,
        "level": level,
        "status": productStatusValues.reverse[status],
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
