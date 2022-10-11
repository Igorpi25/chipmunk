import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'tick.g.dart';

@JsonSerializable()
class Tick extends Equatable {
  const Tick(this.price);

  @JsonKey(name: 'quote')
  final double price;

  factory Tick.fromJson(Map<String, dynamic> json) => _$TickFromJson(json);

  Map<String, dynamic> toJson() => _$TickToJson(this);

  @override
  List<Object?> get props => [price];
}
