import 'dart:async';
import 'package:chipmunk/repositories/price_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc(this._priceRepository, this._asset) : super(PriceLoading()) {
    on<StartPrice>(_onStart);
    on<TickPrice>(_onTick);
  }

  final PriceRepository _priceRepository;
  final String _asset;
  StreamSubscription<String>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStart(StartPrice event, Emitter<PriceState> emit) async {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _priceRepository.tick(_asset).listen((price) => add(TickPrice(price)));
  }

  Future<void> _onTick(TickPrice event, Emitter<PriceState> emit) async {
    emit(PriceValue(event.price));
  }
}
