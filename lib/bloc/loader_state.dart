part of 'loader_bloc.dart';

abstract class LoaderState<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState<T> extends LoaderState<T> {}

class LoadedState<T> extends LoaderState<T> {
  LoadedState(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}
