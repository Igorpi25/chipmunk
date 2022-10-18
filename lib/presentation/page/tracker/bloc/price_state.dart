part of 'price_cubit.dart';

abstract class PriceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PriceLoading extends PriceState {}

abstract class PriceData extends PriceState {
  PriceData(this.price);
  final Price price;
  @override
  List<Object?> get props => [price];
}

class GrowingValue extends PriceData {
  GrowingValue(super.price);
}

class DecreasingValue extends PriceData {
  DecreasingValue(super.price);
}

class StandingValue extends PriceData {
  StandingValue(super.price);
}
