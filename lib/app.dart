import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';
import 'package:chipmunk/domain/repository/market_repository.dart';
import 'package:chipmunk/bloc/loader_cubit.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';
import 'package:chipmunk/page/loading_page.dart';
import 'package:chipmunk/page/tracker_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef PageCubit = LoaderCubit<List<Market>>;
typedef PageState = LoaderState<List<Market>>;
typedef PageLoadingState = LoadingState<List<Market>>;
typedef PageLoadedState = LoadedState<List<Market>>;

class App extends StatelessWidget {
  const App(
      this._priceRepository, this._assetRepository, this._marketRepository,
      {super.key});

  final PriceRepository _priceRepository;
  final AssetRepository _assetRepository;
  final MarketRepository _marketRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<PageCubit, PageState>(
        bloc: PageCubit(_marketRepository.loadMarkets())..load(),
        builder: (context, state) {
          if (state is PageLoadedState) {
            return TrackerPage(state.data, _priceRepository, _assetRepository);
          } else {
            return const LoadingPage();
          }
        },
      ),
    );
  }
}
