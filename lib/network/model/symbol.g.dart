// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Symbol _$SymbolFromJson(Map<String, dynamic> json) => Symbol(
      json['market'] as String,
      json['market_display_name'] as String,
      json['symbol'] as String,
      json['display_name'] as String,
    );

Map<String, dynamic> _$SymbolToJson(Symbol instance) => <String, dynamic>{
      'market': instance.market,
      'symbol': instance.symbol,
      'market_display_name': instance.marketName,
      'display_name': instance.symbolName,
    };
