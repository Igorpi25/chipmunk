import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/market_repository.dart';
import 'package:chipmunk/presentation/page/loader/loader_page.dart';
import 'package:chipmunk/presentation/page/tracker/tracker_page.dart';
import 'package:chipmunk/presentation/bloc/loader_cubit.dart';

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
    return MaterialApp(
      title: 'UI Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<PageCubit, PageState>(
        bloc: PageCubit(context.read<MarketRepository>().loadMarkets())..load(),
        builder: (context, state) {
          if (state is PageLoadedState) {
            return TrackerPage(state.data);
          }
          if (state is LoadingState) {
            return const LoaderPage();
          }
          throw Exception('Unknown state in PageCubit: $state');
        },
      ),
    );
  }
}
