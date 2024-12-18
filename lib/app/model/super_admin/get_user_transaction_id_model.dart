class GetUserTransactionByIdResponse {
  final Data? data;

  GetUserTransactionByIdResponse({
    this.data,
  });

  GetUserTransactionByIdResponse copyWith({
    Data? data,
  }) =>
      GetUserTransactionByIdResponse(
        data: data ?? this.data,
      );

  factory GetUserTransactionByIdResponse.fromJson(Map<String, dynamic> json) =>
      GetUserTransactionByIdResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final bool? status;
  final String? message;
  final List<ResponseDatum>? responseData;
  final List<dynamic>? errorData;

  Data({
    this.status,
    this.message,
    this.responseData,
    this.errorData,
  });

  Data copyWith({
    bool? status,
    String? message,
    List<ResponseDatum>? responseData,
    List<dynamic>? errorData,
  }) =>
      Data(
        status: status ?? this.status,
        message: message ?? this.message,
        responseData: responseData ?? this.responseData,
        errorData: errorData ?? this.errorData,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        message: json["message"],
        responseData: json["response_data"] == null
            ? []
            : List<ResponseDatum>.from(
                json["response_data"]!.map((x) => ResponseDatum.fromJson(x))),
        errorData: json["error_data"] == null
            ? []
            : List<dynamic>.from(json["error_data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_data": responseData == null
            ? []
            : List<dynamic>.from(responseData!.map((x) => x.toJson())),
        "error_data": errorData == null
            ? []
            : List<dynamic>.from(errorData!.map((x) => x)),
      };
}

class ResponseDatum {
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

  ResponseDatum({
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

  ResponseDatum copyWith({
    String? referenceId,
    String? number,
    String? type,
    String? subType,
    String? purchaseType,
    String? productCode,
    String? productAmount,
    String? amountPaid,
    String? discount,
    String? commissionEarn,
    String? status,
    DateTime? regDate,
  }) =>
      ResponseDatum(
        referenceId: referenceId ?? this.referenceId,
        number: number ?? this.number,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        purchaseType: purchaseType ?? this.purchaseType,
        productCode: productCode ?? this.productCode,
        productAmount: productAmount ?? this.productAmount,
        amountPaid: amountPaid ?? this.amountPaid,
        discount: discount ?? this.discount,
        commissionEarn: commissionEarn ?? this.commissionEarn,
        status: status ?? this.status,
        regDate: regDate ?? this.regDate,
      );

  factory ResponseDatum.fromJson(Map<String, dynamic> json) => ResponseDatum(
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
        regDate:
            json["reg_date"] == null ? null : DateTime.parse(json["reg_date"]),
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
      };
}
