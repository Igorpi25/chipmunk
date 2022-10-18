import 'package:chipmunk/domain/model/market.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit(this._markets) : super(MarketsLoaded(_markets));

  final List<Market> _markets;

  void selectMarket(Market market) => emit(MarketSelected(market, _markets));
}
