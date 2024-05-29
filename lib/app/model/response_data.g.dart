// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      responseData: json['response_data'] == null
          ? null
          : ResponseData.fromJson(
              json['response_data'] as Map<String, dynamic>),
      userData: (json['userData'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      // userSettingsData: (json['userSettingsData'] as List<dynamic>?)
      //     ?.map((e) => UserSettingsData.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      beneficiaryData: json['beneficiaryData'] as List<dynamic>?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'response_data': instance.responseData,
      'userData': instance.userData,
    //  'userSettingsData': instance.userSettingsData,
      'beneficiaryData': instance.beneficiaryData,
      'services': instance.services,
      'products': instance.products,
    };
