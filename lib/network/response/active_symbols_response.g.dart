// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_symbols_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveSymbolsResponse _$ActiveSymbolsResponseFromJson(
        Map<String, dynamic> json) =>
    ActiveSymbolsResponse(
      (json['active_symbols'] as List<dynamic>)
          .map((e) => Symbol.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['msg_type'] as String,
    );

Map<String, dynamic> _$ActiveSymbolsResponseToJson(
        ActiveSymbolsResponse instance) =>
    <String, dynamic>{
      'msg_type': instance.type,
      'active_symbols': instance.symbols,
    };
