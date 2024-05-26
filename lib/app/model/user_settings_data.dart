import 'package:json_annotation/json_annotation.dart';

part 'user_settings_data.g.dart';

@JsonSerializable()
class UserSettingsData {
  String? sms;
  String? email;
  String? pushNotification;

  UserSettingsData({
    this.sms,
    this.email,
    this.pushNotification,
  });

  factory UserSettingsData.fromJson(Map<String, dynamic> json) => _$UserSettingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserSettingsDataToJson(this);
}