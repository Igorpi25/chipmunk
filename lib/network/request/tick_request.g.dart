// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tick_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickRequest _$TickRequestFromJson(Map<String, dynamic> json) => TickRequest(
      json['ticks'] as String,
      subscribe: json['subscribe'] as int? ?? 1,
    );

Map<String, dynamic> _$TickRequestToJson(TickRequest instance) =>
    <String, dynamic>{
      'ticks': instance.ticks,
      'subscribe': instance.subscribe,
    };
