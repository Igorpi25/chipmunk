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
        _priceRepository.tick(_asset).listen((price) => _tick(price));
  }

  void _tick(Price price) {
    emit(PriceValue(price));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
