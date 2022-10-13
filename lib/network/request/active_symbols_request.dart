import 'package:chipmunk/network/request/request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'active_symbols_request.g.dart';

enum ActiveSymbol { brief, full }

enum ProductType { basic }

@JsonSerializable()
class ActiveSymbolsRequest extends Request {
  const ActiveSymbolsRequest(
      {this.activeSymbols = ActiveSymbol.brief, this.productType});

  @JsonKey(name: 'active_symbols')
  final ActiveSymbol activeSymbols;

  @JsonKey(name: 'product_type', includeIfNull: false)
  final ProductType? productType;

  factory ActiveSymbolsRequest.fromJson(Map<String, dynamic> json) =>
      _$ActiveSymbolsRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActiveSymbolsRequestToJson(this);

  @override
  List<Object?> get props => [activeSymbols, productType];
}
