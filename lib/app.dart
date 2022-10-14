import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/market_repository.dart';
import 'package:chipmunk/data/mock/repository/mock_market_repository.dart';
import 'package:chipmunk/bloc/loader_cubit.dart';
import 'package:chipmunk/page/loading_page.dart';
import 'package:chipmunk/page/tracker_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef PageCubit = LoaderCubit<List<Market>>;
typedef PageState = LoaderState<List<Market>>;
typedef PageLoadingState = LoadingState<List<Market>>;
typedef PageLoadedState = LoadedState<List<Market>>;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MarketRepository>(
      create: (_) => MockMarketRepository(),
      child: BlocProvider(
        create: (_) =>
            PageCubit(_.read<MarketRepository>().loadMarkets())..load(),
        child: MaterialApp(
          title: 'UI Playground',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<PageCubit, PageState>(
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
