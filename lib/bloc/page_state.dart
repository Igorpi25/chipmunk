part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageLoading extends PageState {}

class PageTracker extends PageState {
  PageTracker(this.markets);

  final List<String> markets;

  @override
  List<Object?> get props => [markets];
}
