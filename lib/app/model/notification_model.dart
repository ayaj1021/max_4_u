class NotificationResponseData {
  bool? status;
  List<Notifications>? transactions;

  NotificationResponseData({this.status, this.transactions});

  factory NotificationResponseData.fromJson(Map<String, dynamic> json) {
    return NotificationResponseData(
      status: json['status'],
      transactions: (json['data'] as List<dynamic>?)
          ?.map((item) => Notifications.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': transactions?.map((item) => item.toJson()).toList(),
    };
  }
}

class Notifications {
  int? id;
  String? heading;
  String? message;
  String? status;
  String? regDate;
  int? userId;

  Notifications({
    this.id,
    this.heading,
    this.message,
    this.status,
    this.regDate,
    this.userId,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      heading: json['heading'],
      message: json['message'],
      status: json['status'],
      regDate: json['reg_date'],
      userId: json['user_id'],
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
