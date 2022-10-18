import 'dart:async';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'price_state.dart';

class PriceCubit extends Cubit<PriceState> {
  PriceCubit(this._priceRepository, this._asset) : super(PriceLoading());

  final PriceRepository _priceRepository;
  final Asset _asset;
  StreamSubscription<Price>? _tickerSubscription;

  void start() async {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _priceRepository.startTicking(_asset).listen((price) => _tick(price));
  }

  void _tick(Price price) {
    final currentState = state;
    if (currentState is PriceLoading) {
      emit(StandingValue(price));
    } else if (currentState is PriceData) {
      final prev = currentState.price;
      final next = price;
      emit(_getSplittedPriceValue(prev, next));
    } else {
      throw Exception('Unknown PriceState');
    }
  }

  PriceData _getSplittedPriceValue(Price prev, Price next) {
    if (next.value > prev.value) {
      return GrowingValue(next);
    } else if (next.value < prev.value) {
      return DecreasingValue(next);
    } else {
      return StandingValue(next);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    _priceRepository.stopTicking(_asset);
    return super.close();
  }
}
