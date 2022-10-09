part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartTracker extends PageEvent {}
