import 'package:equatable/equatable.dart';

class Market extends Equatable {
  const Market(this.id, this.name);
  final String id;
  final String name;
  @override
  List<Object?> get props => [id, name];
}
