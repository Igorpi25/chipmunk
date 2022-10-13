import 'package:chipmunk/network/model/tick.dart';
import 'package:chipmunk/network/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticks_response.g.dart';

@JsonSerializable()
class TicksResponse extends Response {
  const TicksResponse(this.tick, super.type);

  final Tick tick;

  factory TicksResponse.fromJson(Map<String, dynamic> json) =>
      _$TicksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicksResponseToJson(this);

  @override
  List<Object?> get props => [tick, type];
}
