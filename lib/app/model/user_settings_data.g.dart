// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettingsData _$UserSettingsDataFromJson(Map<String, dynamic> json) =>
    UserSettingsData(
      sms: json['sms'] as String?,
      email: json['email'] as String?,
      pushNotification: json['pushNotification'] as String?,
    );

Map<String, dynamic> _$UserSettingsDataToJson(UserSettingsData instance) =>
    <String, dynamic>{
      'sms': instance.sms,
      'email': instance.email,
      'pushNotification': instance.pushNotification,
    };
