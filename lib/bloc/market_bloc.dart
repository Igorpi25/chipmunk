import 'package:chipmunk/repositories/market_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'market_state.dart';
part 'market_event.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository _marketRepository;
  // TODO perhaps move repository from Bloc to BlocProvider?
  late List<String> _markets;

  MarketBloc(this._marketRepository) : super(MarketLoading()) {
    on<StartMarkets>(_onStarted);
    on<SelectMarket>(_onSelected);
  }

  Future<void> _onStarted(StartMarkets event, Emitter<MarketState> emit) async {
    emit(MarketLoading());
    _markets = await _marketRepository.loadMarkets();
    emit(MarketsLoaded(_markets));
  }

  Future<void> _onSelected(SelectMarket event, Emitter<Equatable> emit) async {
    final selectedValue = event.market;
    emit(MarketSelected(selectedValue, _markets));
  }
}
