part of 'price_cubit.dart';

abstract class PriceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PriceLoading extends PriceState {}

class PriceValue extends PriceState {
  PriceValue(this.price);
  final Price price;
  @override
  List<Object?> get props => [price];
}
