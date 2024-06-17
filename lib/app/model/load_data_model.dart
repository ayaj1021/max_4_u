
class UserData {
  String? uniqueId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? level;
  String? status;
  String? emailStatus;
  DateTime? regDate;

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
      uniqueId: json['unique_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      level: json['level'],
      status: json['status'],
      emailStatus: json['email_status'],
      regDate: json['reg_date'] != null ? DateTime.parse(json['reg_date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile_number': mobileNumber,
      'level': level,
      'status': status,
      'email_status': emailStatus,
      'reg_date': regDate?.toIso8601String(),
    };
  }
}

class UserAccount {
  int? balance;

  UserAccount({this.balance});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(balance: json['balance']);
  }

  Map<String, dynamic> toJson() {
    return {'balance': balance};
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

  factory UserSettingsData.fromJson(Map<String, dynamic> json) {
    return UserSettingsData(
      sms: json['sms'],
      email: json['email'],
      pushNotification: json['push_notification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sms': sms,
      'email': email,
      'push_notification': pushNotification,
    };
  }
}

class BeneficiaryData {
  String? phone;

  BeneficiaryData({
    this.phone,
  });

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) {
    return BeneficiaryData(
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
}
class Service {
  String? category;

  Service({this.category});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(category: json['category']);
  }

  Map<String, dynamic> toJson() {
    return {'category': category};
  }
}

class Product {
  String? name;
  String? code;
  String? serviceName;
  String? category;
  String? price;
  String? consumerDiscount;
  String? vendorDiscount;
  String? serviceFee;
  String? logo;
  String? duration;
  String? status;

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
      name: json['name'],
      code: json['code'],
      serviceName: json['service_name'],
      category: json['category'],
      price: json['price'],
      consumerDiscount: json['consumer_discount'],
      vendorDiscount: json['vendor_discount'],
      serviceFee: json['service_fee'],
      logo: json['logo'],
      duration: json['duration'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'service_name': serviceName,
      'category': category,
      'price': price,
      'consumer_discount': consumerDiscount,
      'vendor_discount': vendorDiscount,
      'service_fee': serviceFee,
      'logo': logo,
      'duration': duration,
      'status': status,
    };
  }
}

class Transaction {
  String? referenceId;
  String? number;
  String? type;
  String? subType;
  String? purchaseType;
  String? productCode;
  String? productAmount;
  String? amountPaid;
  String? discount;
  String? commissionEarn;
  String? status;
  DateTime? regDate;

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
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      referenceId: json['reference_id'],
      number: json['number'],
      type: json['type'],
      subType: json['sub_type'],
      purchaseType: json['purchase_type'],
      productCode: json['product_code'],
      productAmount: json['product_amount'],
      amountPaid: json['amount_paid'],
      discount: json['discount'],
      commissionEarn: json['commission_earn'],
      status: json['status'],
      regDate: json['reg_date'] != null ? DateTime.parse(json['reg_date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference_id': referenceId,
      'number': number,
      'type': type,
      'sub_type': subType,
      'purchase_type': purchaseType,
      'product_code': productCode,
      'product_amount': productAmount,
      'amount_paid': amountPaid,
      'discount': discount,
      'commission_earn': commissionEarn,
      'status': status,
      'reg_date': regDate?.toIso8601String(),
    };
  }
}

class TransactionHistory {
  List<Transaction>? data;
  int? currentPage;
  int? totalData;
  int? totalResult;

  TransactionHistory({
    this.data,
    this.currentPage,
    this.totalData,
    this.totalResult,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    var transactions = (json['data'] as List)
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
    return TransactionHistory(
      data: transactions,
      currentPage: json['current_page'],
      totalData: json['total_data'],
      totalResult: json['total_result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((transaction) => transaction.toJson()).toList(),
      'current_page': currentPage,
      'total_data': totalData,
      'total_result': totalResult,
    };
  }
}

class AutoRenewal {
  List<dynamic>? data;
  int? currentPage;
  int? totalData;
  int? totalResult;

  AutoRenewal({
    this.data,
    this.currentPage,
    this.totalData,
    this.totalResult,
  });

  factory AutoRenewal.fromJson(Map<String, dynamic> json) {
    return AutoRenewal(
      data: json['data'],
      currentPage: json['current_page'],
      totalData: json['total_data'],
      totalResult: json['total_result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'current_page': currentPage,
      'total_data': totalData,
      'total_result': totalResult,
    };
  }
}

class VerificationStatus {
  String? bvn;
  String? nin;
  String? ninImageLink;
  String? vendorImageLink;
  String? status;

  VerificationStatus({
    this.bvn,
    this.nin,
    this.ninImageLink,
    this.vendorImageLink,
    this.status,
  });

  factory VerificationStatus.fromJson(Map<String, dynamic> json) {
    return VerificationStatus(
      bvn: json['bvn'],
      nin: json['nin'],
      ninImageLink: json['nin_image_link'],
      vendorImageLink: json['vendor_image_link'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bvn': bvn,
      'nin': nin,
      'nin_image_link': ninImageLink,
      'vendor_image_link': vendorImageLink,
      'status': status,
    };
  }
}

class LoadDataData {
  List<UserData>? userData;
  UserAccount? userAccount;
  List<UserSettingsData>? userSettingsData;
  List<BeneficiaryData>? beneficiaryData;
  List<Service>? services;
  List<Product>? products;
  TransactionHistory? transactionHistory;
  AutoRenewal? autoRenewal;
  List<dynamic>? myVendor;
  VerificationStatus? verificationStatus;
  bool? status;

  LoadDataData({
    this.userData,
    this.userAccount,
    this.userSettingsData,
    this.beneficiaryData,
    this.services,
    this.products,
    this.transactionHistory,
    this.autoRenewal,
    this.myVendor,
    this.verificationStatus,
    this.status,
  });

  factory LoadDataData.fromJson(Map<String, dynamic> json) {
    var userDataList = (json['user_data'] as List?)
        ?.map((user) => UserData.fromJson(user))
        .toList();
    var userSettingsDataList = (json['user_settings_data'] as List?)
        ?.map((setting) => UserSettingsData.fromJson(setting))
        .toList();
    var beneficiaryDataList = (json['beneficiary_data'] as List?)
        ?.map((beneficiary) => BeneficiaryData.fromJson(beneficiary))
        .toList();
    var servicesList = (json['services'] as List?)
        ?.map((service) => Service.fromJson(service))
        .toList();
    var productsList = (json['products'] as List?)
        ?.map((product) => Product.fromJson(product))
        .toList();

    return LoadDataData(
      userData: userDataList,
      userAccount: json['user_account'] != null ? UserAccount.fromJson(json['user_account']) : null,
      userSettingsData: userSettingsDataList,
      beneficiaryData: beneficiaryDataList,
      services: servicesList,
      products: productsList,
      transactionHistory: json['transaction_history'] != null ? TransactionHistory.fromJson(json['transaction_history']) : null,
      autoRenewal: json['auto_renewal'] != null ? AutoRenewal.fromJson(json['auto_renewal']) : null,
      myVendor: json['my_vendor'],
      verificationStatus: json['verification_status'] != null ? VerificationStatus.fromJson(json['verification_status']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_data': userData?.map((user) => user.toJson()).toList(),
      'user_account': userAccount?.toJson(),
      'user_settings_data': userSettingsData?.map((setting) => setting.toJson()).toList(),
      'beneficiary_data': beneficiaryData?.map((beneficiary) => beneficiary.toJson()).toList(),
      'services': services?.map((service) => service.toJson()).toList(),
      'products': products?.map((product) => product.toJson()).toList(),
      'transaction_history': transactionHistory?.toJson(),
      'auto_renewal': autoRenewal?.toJson(),
      'my_vendor': myVendor,
      'verification_status': verificationStatus?.toJson(),
      'status': status,
    };
  }
}


