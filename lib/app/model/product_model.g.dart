// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      code: json['code'] as String?,
      serviceName: json['serviceName'] as String?,
      category: json['category'] as String?,
      price: json['price'] as String?,
      consumerCommission: json['consumerCommission'] as String?,
      consumerDiscount: json['consumerDiscount'] as String?,
      vendorCommission: json['vendorCommission'] as String?,
      vendorDiscount: json['vendorDiscount'] as String?,
      serviceFee: json['serviceFee'] as String?,
      logo: json['logo'] as String?,
      duration: json['duration'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'serviceName': instance.serviceName,
      'category': instance.category,
      'price': instance.price,
      'consumerCommission': instance.consumerCommission,
      'consumerDiscount': instance.consumerDiscount,
      'vendorCommission': instance.vendorCommission,
      'vendorDiscount': instance.vendorDiscount,
      'serviceFee': instance.serviceFee,
      'logo': instance.logo,
      'duration': instance.duration,
      'status': instance.status,
    };
