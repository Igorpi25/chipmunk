import 'package:chipmunk/repositories/market_repository.dart';
import 'package:chipmunk/bloc/loader_bloc.dart';
import 'package:chipmunk/page/loading_page.dart';
import 'package:chipmunk/page/tracker_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef PageBloc = LoaderBloc<List<String>>;
typedef PageState = LoaderState<List<String>>;
typedef PageLoadingState = LoadingState<List<String>>;
typedef PageLoadedState = LoadedState<List<String>>;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MarketRepository(),
      child: BlocProvider(
        create: (_) =>
            PageBloc(_.read<MarketRepository>().loadMarkets())..add(Load()),
        child: MaterialApp(
          title: 'UI Playground',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              if (state is PageLoadingState) {
                return const LoadingPage();
              } else if (state is PageLoadedState) {
                return TrackerPage(state.data);
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
