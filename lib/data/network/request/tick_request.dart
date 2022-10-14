import 'package:chipmunk/data/network/request/request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tick_request.g.dart';

@JsonSerializable()
class TickRequest extends Request {
  const TickRequest(this.ticks, {this.subscribe = 1});

  final String ticks;
  final int subscribe;

  factory TickRequest.fromJson(Map<String, dynamic> json) =>
      _$TickRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TickRequestToJson(this);

  @override
  List<Object?> get props => [ticks, subscribe];
}
