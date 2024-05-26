// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      uniqueId: json['uniqueId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      balance: json['balance'] as String?,
      level: json['level'] as String?,
      status: json['status'] as String?,
      emailStatus: json['emailStatus'] as String?,
      regDate: json['regDate'] == null
          ? null
          : DateTime.parse(json['regDate'] as String),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'balance': instance.balance,
      'level': instance.level,
      'status': instance.status,
      'emailStatus': instance.emailStatus,
      'regDate': instance.regDate?.toIso8601String(),
    };
