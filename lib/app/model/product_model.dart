import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
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


  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}