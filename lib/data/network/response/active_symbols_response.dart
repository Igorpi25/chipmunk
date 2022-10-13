import 'package:chipmunk/data/network/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:chipmunk/data/network/model/symbol.dart';

part 'active_symbols_response.g.dart';

@JsonSerializable()
class ActiveSymbolsResponse extends Response {
  const ActiveSymbolsResponse(this.symbols, super.type);

  @JsonKey(name: 'active_symbols')
  final List<Symbol> symbols;

  factory ActiveSymbolsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveSymbolsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveSymbolsResponseToJson(this);

  @override
  List<Object?> get props => [symbols, type];
}
