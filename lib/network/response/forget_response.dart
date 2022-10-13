import 'package:chipmunk/network/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_response.g.dart';

@JsonSerializable()
class ForgetResponse extends Response {
  const ForgetResponse(this.forget, super.type);

  final int forget;

  factory ForgetResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetResponseToJson(this);

  @override
  List<Object?> get props => [forget, type];
}
