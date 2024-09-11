

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


part 'base_response.g.dart';

@immutable
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  const BaseResponse({
    required this.status,
    this.data,
    this.message,
  }) : super();

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$BaseResponseFromJson(json, fromJsonT);
  }

  factory BaseResponse.fromMap(Map<String, dynamic> json) {
    return BaseResponse(
      data: json['data'] as T?,
      status: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? 'An Error occured',
    );
  }
  final T? data;
  @JsonKey(name: 'success')
  final bool status;
  final String? message;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  @override
  String toString() {
    return '''BaseResponse{status: $status, data: $data, message: $message, }''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseResponse<T> &&
        other.status == status &&
        other.data == data &&
        other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^ data.hashCode ^ message.hashCode;
  }
}


//retrofit - for network request
//json_serializable - for json serialization
//json annotation - for json serialization