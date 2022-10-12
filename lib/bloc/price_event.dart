part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartPrice extends PriceEvent {}

class TickPrice extends PriceEvent {
  TickPrice(this.price);
  final Price price;
  @override
  List<Object?> get props => [price];
}
