import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'market_state.dart';
part 'market_event.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final List<String> _markets;

  MarketBloc(this._markets) : super(MarketsLoaded(_markets)) {
    on<SelectMarket>(_onSelected);
  }

  Future<void> _onSelected(
      SelectMarket event, Emitter<MarketState> emit) async {
    final selectedValue = event.market;
    emit(MarketSelected(selectedValue, _markets));
  }
}
