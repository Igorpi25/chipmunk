import 'package:chipmunk/network/model/message.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:chipmunk/network/model/symbol.dart';

part 'active_symbols.g.dart';

@JsonSerializable()
class ActiveSymbols extends Message {
  const ActiveSymbols(this.symbols, type) : super(type);

  @JsonKey(name: 'active_symbols')
  final List<Symbol> symbols;

  factory ActiveSymbols.fromJson(Map<String, dynamic> json) =>
      _$ActiveSymbolsFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveSymbolsToJson(this);

  @override
  List<Object?> get props => [symbols, type];
}
