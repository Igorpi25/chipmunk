import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class Response extends Equatable {
  const Response(this.type);

  @JsonKey(name: 'msg_type')
  final String type;

  @override
  List<Object?> get props => [type];
}
