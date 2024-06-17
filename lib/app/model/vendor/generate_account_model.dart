class BankData {
  bool? status;
  String? message;
  List<BankAccount>? responseData;
  List<dynamic>? errorData;

  BankData({this.status, this.message, this.responseData, this.errorData});

  factory BankData.fromJson(Map<String, dynamic> json) {
    return BankData(
      status: json['status'],
      message: json['message'],
      responseData: json['response_data'] != null
          ? (json['response_data'] as List).map((i) => BankAccount.fromJson(i)).toList()
          : null,
      errorData: json['error_data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'response_data': responseData != null ? responseData!.map((i) => i.toJson()).toList() : null,
      'error_data': errorData,
    };
  }
}

class BankAccount {
  int? id;
  String? bankCode;
  String? bankName;
  String? accountName;
  String? accountNumber;
  int? userId;
  String? regDate;

  BankAccount({
    this.id,
    this.bankCode,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.userId,
    this.regDate,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'],
      bankCode: json['bank_code'],
      bankName: json['bank_name'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      userId: json['user_id'],
      regDate: json['reg_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bank_code': bankCode,
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
      'user_id': userId,
      'reg_date': regDate,
    };
  }
}
