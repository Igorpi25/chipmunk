part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartPrice extends PriceEvent {
  StartPrice();
  @override
  List<Object?> get props => [];
}

class TickPrice extends PriceEvent {
  TickPrice(this.price);
  final String price;
  @override
  List<Object?> get props => [price];
}
