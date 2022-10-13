// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_symbols_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveSymbolsRequest _$ActiveSymbolsRequestFromJson(
        Map<String, dynamic> json) =>
    ActiveSymbolsRequest(
      activeSymbols:
          $enumDecodeNullable(_$ActiveSymbolEnumMap, json['active_symbols']) ??
              ActiveSymbol.brief,
      productType:
          $enumDecodeNullable(_$ProductTypeEnumMap, json['product_type']),
    );

Map<String, dynamic> _$ActiveSymbolsRequestToJson(
    ActiveSymbolsRequest instance) {
  final val = <String, dynamic>{
    'active_symbols': _$ActiveSymbolEnumMap[instance.activeSymbols]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('product_type', _$ProductTypeEnumMap[instance.productType]);
  return val;
}

const _$ActiveSymbolEnumMap = {
  ActiveSymbol.brief: 'brief',
  ActiveSymbol.full: 'full',
};

const _$ProductTypeEnumMap = {
  ProductType.basic: 'basic',
};
