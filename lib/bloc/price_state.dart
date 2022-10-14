part of 'price_cubit.dart';

abstract class PriceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PriceLoading extends PriceState {}

abstract class PriceValue extends PriceState {
  PriceValue(this.price);
  final Price price;
  @override
  List<Object?> get props => [price];
}

class GrowingValue extends PriceValue {
  GrowingValue(super.price);
}

class DecreasingValue extends PriceValue {
  DecreasingValue(super.price);
}

class StandingValue extends PriceValue {
  StandingValue(super.price);
}
