import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'loader_state.dart';
part 'loader_event.dart';

class LoaderBloc<T> extends Bloc<LoaderEvent, LoaderState<T>> {
  LoaderBloc(this._loader) : super(LoadingState<T>()) {
    on<Load>(_startLoad);
  }

  final Future<T> _loader;

  Future<void> _startLoad(
      LoaderEvent event, Emitter<LoaderState<T>> emit) async {
    final T markets = await _loader;
    emit(LoadedState<T>(markets));
  }
}
