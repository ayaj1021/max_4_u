import 'package:json_annotation/json_annotation.dart';
//import 'package:max_4_u/app/model/product_model.dart';
import 'package:max_4_u/app/model/service_model.dart';
import 'package:max_4_u/app/model/user_data.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData {
  final bool? status;
  final String? message;
  @JsonKey(name: 'response_data')
  final ResponseData? responseData;
  final List<UserData>? userData;
 // final List<UserSettingsData>? userSettingsData;
  final List<dynamic>? beneficiaryData;
  final List<Service>? services;
  //final List<Product>? products;

  ResponseData({
    this.status,
    this.message,
    this.responseData,
    this.userData,
    //this.userSettingsData,
    this.beneficiaryData,
    this.services,
   // this.products,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}