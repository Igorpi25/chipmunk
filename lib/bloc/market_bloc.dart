import 'package:chipmunk/domain/model/market.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'market_state.dart';
part 'market_event.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc(this._markets) : super(MarketsLoaded(_markets)) {
    on<SelectMarket>(_onSelected);
  }

  final List<Market> _markets;

  Future<void> _onSelected(
      SelectMarket event, Emitter<MarketState> emit) async {
    final market = event.market;
    emit(MarketSelected(market, _markets));
  }
}
