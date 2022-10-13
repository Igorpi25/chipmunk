import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'symbol.g.dart';

@JsonSerializable()
class Symbol extends Equatable {
  const Symbol(this.market, this.marketName, this.symbol, this.symbolName);

  final String market, symbol;

  @JsonKey(name: 'market_display_name')
  final String marketName;

  @JsonKey(name: 'display_name')
  final String symbolName;

  factory Symbol.fromJson(Map<String, dynamic> json) => _$SymbolFromJson(json);

  Map<String, dynamic> toJson() => _$SymbolToJson(this);

  @override
  List<Object?> get props => [market, marketName, symbol, symbolName];
}
