import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';
@JsonSerializable()
class UserData {
 final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? balance;
  final String? level;
  final String? status;
  final String? emailStatus;
  final DateTime? regDate;

  UserData({
    this.uniqueId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.balance,
    this.level,
    this.status,
    this.emailStatus,
    this.regDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}