import 'package:chipmunk/bloc/asset_bloc.dart';
import 'package:chipmunk/bloc/market_bloc.dart';
import 'package:chipmunk/bloc/price_bloc.dart';
import 'package:chipmunk/repositories/asset_repository.dart';
import 'package:chipmunk/repositories/market_repository.dart';
import 'package:chipmunk/repositories/price_repository.dart';
import 'package:chipmunk/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Price Tracker"),
      ),
      body: Align(
        alignment: AlignmentDirectional.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider<MarketRepository>(
                        create: (_) => MarketRepository()),
                    RepositoryProvider<AssetRepository>(
                        create: (_) => AssetRepository()),
                    RepositoryProvider<PriceRepository>(
                        create: (_) => PriceRepository()),
                  ],
                  child: BlocProvider(
                    create: (_) => MarketBloc(_.read<MarketRepository>())
                      ..add(StartMarkets()),
                    child: BlocBuilder<MarketBloc, MarketState>(
                      builder: (context, state) {
                        if (state is MarketLoading) {
                          return Column(
                            children: const [
                              PlaceholderDropdown('Loading markets ...'),
                              PlaceholderDropdown('No assets'),
                            ],
                          );
                        }
                        if (state is MarketsLoaded) {
                          return Column(
                            children: [
                              RevealedDropdown(state.markets, 'Select market',
                                  (_) => _marketSelected(context, _)),
                              const PlaceholderDropdown('No assets'),
                            ],
                          );
                        } else if (state is MarketSelected) {
                          return Column(
                            children: [
                              StatedDropdown(state.markets, state.market,
                                  (_) => _marketSelected(context, _)),
                              BlocProvider(
                                key: ValueKey(state.market),
                                create: (_) => AssetBloc(
                                    _.read<AssetRepository>(), state.market)
                                  ..add(LoadAssets()),
                                child: BlocBuilder<AssetBloc, AssetState>(
                                  builder: (context, state) {
                                    if (state is AssetsLoading) {
                                      return const PlaceholderDropdown(
                                          'Loading assets ...');
                                    } else if (state is AssetsLoaded) {
                                      return RevealedDropdown(
                                          state.assets,
                                          'Select asset',
                                          (_) => _assetSelected(context, _));
                                    } else if (state is AssetSelected) {
                                      return Column(
                                        children: [
                                          StatedDropdown(
                                              state.assets,
                                              state.asset,
                                              (_) =>
                                                  _assetSelected(context, _)),
                                          BlocProvider(
                                            key: ValueKey(state.asset),
                                            create: (_) => PriceBloc(
                                                _.read<PriceRepository>(),
                                                state.asset)
                                              ..add(StartPrice()),
                                            child: BlocBuilder<PriceBloc,
                                                PriceState>(
                                              builder: (context, state) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  child: () {
                                                    if (state is PriceLoading) {
                                                      return const CircularProgressIndicator();
                                                    } else if (state
                                                        is PriceValue) {
                                                      return Text(
                                                          'Price: ${state.price}');
                                                    } else {
                                                      throw Exception(
                                                          'Unknown state in PriceBloc: $state');
                                                    }
                                                  }(),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      throw Exception(
                                          'Unknown state in AssetBloc: $state');
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          throw Exception(
                              'Unknown state in MarketBloc: $state');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _marketSelected(BuildContext context, String market) {
    context.read<MarketBloc>().add(SelectMarket(market));
  }

  void _assetSelected(BuildContext context, String asset) {
    context.read<AssetBloc>().add(SelectAsset(asset));
  }
}
