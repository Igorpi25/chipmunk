// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_symbols.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveSymbols _$ActiveSymbolsFromJson(Map<String, dynamic> json) =>
    ActiveSymbols(
      (json['active_symbols'] as List<dynamic>)
          .map((e) => Symbol.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['msg_type'],
    );

Map<String, dynamic> _$ActiveSymbolsToJson(ActiveSymbols instance) =>
    <String, dynamic>{
      'msg_type': instance.type,
      'active_symbols': instance.symbols,
    };
