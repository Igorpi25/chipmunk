part of 'market_bloc.dart';

abstract class MarketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartMarkets extends MarketEvent {}

class SelectMarket extends MarketEvent {
  SelectMarket(this.market);
  final String market;
  @override
  List<Object?> get props => [market];
}
