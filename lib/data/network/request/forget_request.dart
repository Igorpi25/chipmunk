import 'package:chipmunk/data/network/request/request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_request.g.dart';

@JsonSerializable()
class ForgetRequest extends Request {
  const ForgetRequest(this.subscriptionId);

  @JsonKey(name: 'forget')
  final String subscriptionId;

  factory ForgetRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForgetRequestToJson(this);

  @override
  List<Object?> get props => [subscriptionId];
}
