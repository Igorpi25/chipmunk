part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MarketsLoaded extends MarketState {
  MarketsLoaded(this.markets);

  final List<Market> markets;

  @override
  List<Object?> get props => [markets];
}

class MarketSelected extends MarketState {
  MarketSelected(this.market, this.markets);

  final List<Market> markets;
  final Market market;

  @override
  List<Object?> get props => [market, markets];
}
