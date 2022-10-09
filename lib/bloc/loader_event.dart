part of 'loader_bloc.dart';

abstract class LoaderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Load extends LoaderEvent {}
