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
      marketIsOpen: json['exchange_is_open'] == null
          ? true
          : Symbol._boolFromInt(json['exchange_is_open'] as int),
    );

Map<String, dynamic> _$SymbolToJson(Symbol instance) => <String, dynamic>{
      'market': instance.market,
      'symbol': instance.symbol,
      'market_display_name': instance.marketName,
      'display_name': instance.symbolName,
      'exchange_is_open': Symbol._boolToInt(instance.marketIsOpen),
    };
