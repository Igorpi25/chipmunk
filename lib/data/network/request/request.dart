import 'package:equatable/equatable.dart';

abstract class Request extends Equatable {
  const Request();

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson();
}
