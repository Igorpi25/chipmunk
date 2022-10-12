import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  const Asset(this.id, this.name);
  final String id;
  final String name;
  @override
  List<Object?> get props => [id, name];
}
