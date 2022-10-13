// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tick _$TickFromJson(Map<String, dynamic> json) => Tick(
      (json['quote'] as num).toDouble(),
      json['id'] as String,
    );

Map<String, dynamic> _$TickToJson(Tick instance) => <String, dynamic>{
      'quote': instance.quote,
      'id': instance.subscriptionId,
    };
