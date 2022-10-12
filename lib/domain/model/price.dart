import 'package:equatable/equatable.dart';

class Price extends Equatable {
  const Price(this.value);
  final double value;
  @override
  List<Object?> get props => [value];
}
