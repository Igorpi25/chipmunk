import 'package:chipmunk/repositories/market_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_state.dart';
part 'page_event.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc(this._marketRepository) : super(PageLoading()) {
    on<StartTracker>(_startTracker);
  }

  final MarketRepository _marketRepository;

  Future<void> _startTracker(PageEvent event, Emitter<PageState> emit) async {
    final markets = await _marketRepository.loadMarkets();
    emit(PageTracker(markets));
  }
}
