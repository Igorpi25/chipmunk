import 'package:chipmunk/bloc/page_bloc.dart';
import 'package:chipmunk/page/loading_page.dart';
import 'package:chipmunk/repositories/market_repository.dart';
import 'package:flutter/material.dart';
import 'package:chipmunk/page/tracker_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MarketRepository(),
      child: BlocProvider(
        create: (_) =>
            PageBloc(_.read<MarketRepository>())..add(StartTracker()),
        child: MaterialApp(
          title: 'UI Playground',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              if (state is PageLoading) {
                return const LoadingPage();
              } else if (state is PageTracker) {
                return TrackerPage(state.markets);
              } else {
                throw Exception('Unknown state in PageBloc: $state');
              }
            },
          ),
        ),
      ),
    );
  }
}
