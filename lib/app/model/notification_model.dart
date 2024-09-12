class NotificationResponseData {
  final bool? status;
  final TransactionData? data;

  NotificationResponseData({this.status, this.data});

  factory NotificationResponseData.fromJson(Map<String, dynamic> json) {
    return NotificationResponseData(
      status: json['status'] as bool?,
      data: json['data'] != null
          ? TransactionData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class TransactionData {
  final List<Transaction>? transactions;

  TransactionData({this.transactions});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      transactions: (json['data'] as List<dynamic>?)
          ?.map((item) => Transaction.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': transactions?.map((transaction) => transaction.toJson()).toList(),
    };
  }
}

class Transaction {
  final int? id;
  final String? heading;
  final String? message;
  final String? status;
  final String? regDate;
  final int? userId;

  Transaction({
    this.id,
    this.heading,
    this.message,
    this.status,
    this.regDate,
    this.userId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int?,
      heading: json['heading'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      regDate: json['reg_date'] as String?,
      userId: json['user_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'heading': heading,
      'message': message,
      'status': status,
      'reg_date': regDate,
      'user_id': userId,
    };
  }
}
