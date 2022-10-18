import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'loader_state.dart';

class LoaderCubit<T> extends Cubit<LoaderState<T>> {
  LoaderCubit(this._loader) : super(LoadingState<T>());

  final Future<T> _loader;

  void load() async {
    final T data = await _loader;
    emit(LoadedState<T>(data));
  }
}
