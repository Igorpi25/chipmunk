part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MarketLoading extends MarketState {}

class MarketsLoaded extends MarketState {
  MarketsLoaded(this.markets);

  final List<String> markets;

  @override
  List<Object?> get props => [markets];
}

class MarketSelected extends MarketState {
  MarketSelected(this.market, this.markets);

  final List<String> markets;
  final String market;

  @override
  List<Object?> get props => [market, markets];
}
