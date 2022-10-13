// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetResponse _$ForgetResponseFromJson(Map<String, dynamic> json) =>
    ForgetResponse(
      json['forget'] as int,
      json['msg_type'] as String,
    );

Map<String, dynamic> _$ForgetResponseToJson(ForgetResponse instance) =>
    <String, dynamic>{
      'msg_type': instance.type,
      'forget': instance.forget,
    };
