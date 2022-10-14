// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicksResponse _$TicksResponseFromJson(Map<String, dynamic> json) =>
    TicksResponse(
      Tick.fromJson(json['tick'] as Map<String, dynamic>),
      json['msg_type'] as String,
    );

Map<String, dynamic> _$TicksResponseToJson(TicksResponse instance) =>
    <String, dynamic>{
      'msg_type': instance.type,
      'tick': instance.tick,
    };
