import 'package:chipmunk/bloc/asset_cubit.dart';
import 'package:chipmunk/bloc/loader_cubit.dart';
import 'package:chipmunk/bloc/market_cubit.dart';
import 'package:chipmunk/bloc/price_cubit.dart';
import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_asset_repository.dart';
import 'package:chipmunk/data/network/repository/network_price_repository.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';
import 'package:chipmunk/widgets/dropdown.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef RevealCubit = LoaderCubit<List<Asset>>;
typedef RevealState = LoaderState<List<Asset>>;
typedef RevealLoadingState = LoadingState<List<Asset>>;
typedef RevealLoadedState = LoadedState<List<Asset>>;

class MarketDropdownViewmodel extends Equatable {
  MarketDropdownViewmodel.from(Market market)
      : name = market.name,
        id = market.id;

  final String name, id;

  Market toMarket() => Market(id, name);

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [name, id];
}

class AssetDropdownViewmodel extends Equatable {
  AssetDropdownViewmodel.from(Asset market)
      : name = market.name,
        id = market.id;

  final String name, id;

  Asset toAsset() => Asset(id, name);

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [name, id];
}

class TrackerPage extends StatelessWidget {
  const TrackerPage(this._markets, {super.key});

  final List<Market> _markets;

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
                    RepositoryProvider<AssetRepository>(
                        create: (_) =>
                            NetworkAssetRepository(_.read<NetworkUtil>())),
                    RepositoryProvider<PriceRepository>(
                        create: (_) =>
                            NetworkPriceRepository(_.read<NetworkUtil>())),
                  ],
                  child: BlocProvider(
                    create: (_) => MarketCubit(_markets),
                    child: BlocBuilder<MarketCubit, MarketState>(
                      builder: (context, state) {
                        if (state is MarketsLoaded) {
                          return Column(
                            children: [
                              RevealedDropdown<MarketDropdownViewmodel>(
                                  state.markets
                                      .map((market) =>
                                          MarketDropdownViewmodel.from(market))
                                      .toList(),
                                  'Select market',
                                  (_) => _marketSelected(context, _)),
                              const PlaceholderDropdown('No assets'),
                            ],
                          );
                        } else if (state is MarketSelected) {
                          return Column(
                            children: [
                              StatedDropdown<MarketDropdownViewmodel>(
                                  state.markets
                                      .map((market) =>
                                          MarketDropdownViewmodel.from(market))
                                      .toList(),
                                  MarketDropdownViewmodel.from(state.market),
                                  (_) => _marketSelected(context, _)),
                              BlocProvider(
                                key: ValueKey(state.market),
                                create: (_) =>
                                    RevealCubit(_revealLoader(_, state.market))
                                      ..load(),
                                child: BlocBuilder<RevealCubit, RevealState>(
                                    builder: (context, state) {
                                  if (state is RevealLoadingState) {
                                    return const PlaceholderDropdown(
                                        'Assets loading ...');
                                  } else if (state is RevealLoadedState) {
                                    return BlocProvider(
                                      key: ValueKey(state.data),
                                      create: (_) => AssetCubit(state.data),
                                      child:
                                          BlocBuilder<AssetCubit, AssetState>(
                                        builder: (context, state) {
                                          if (state is AssetsLoaded) {
                                            return RevealedDropdown<
                                                    AssetDropdownViewmodel>(
                                                state.assets
                                                    .map((asset) =>
                                                        AssetDropdownViewmodel
                                                            .from(asset))
                                                    .toList(),
                                                'Select asset',
                                                (_) =>
                                                    _assetSelected(context, _));
                                          } else if (state is AssetSelected) {
                                            return Column(
                                              children: [
                                                StatedDropdown<
                                                        AssetDropdownViewmodel>(
                                                    state.assets
                                                        .map((asset) =>
                                                            AssetDropdownViewmodel
                                                                .from(asset))
                                                        .toList(),
                                                    AssetDropdownViewmodel.from(
                                                        state.asset),
                                                    (_) => _assetSelected(
                                                        context, _)),
                                                BlocProvider(
                                                  key: ValueKey(state.asset),
                                                  create: (_) => PriceCubit(
                                                      _.read<PriceRepository>(),
                                                      state.asset)
                                                    ..start(),
                                                  child: BlocBuilder<PriceCubit,
                                                      PriceState>(
                                                    builder: (context, state) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 16),
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        child: () {
                                                          if (state
                                                              is PriceLoading) {
                                                            return const CircularProgressIndicator();
                                                          } else if (state
                                                              is PriceValue) {
                                                            return Text(
                                                              'Price: ${state.price.value}',
                                                              style: TextStyle(
                                                                  color:
                                                                      _priceColorByState(
                                                                          state)),
                                                            );
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
                                    );
                                  } else {
                                    throw Exception(
                                        'Unknown state in RevealBloc: $state');
                                  }
                                }),
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

  Color _priceColorByState(PriceValue state) {
    if (state is GrowingValue) return Colors.green;
    if (state is DecreasingValue) return Colors.red;
    if (state is StandingValue) return Colors.grey;

    throw Exception('Unknown PriceValue state');
  }

  void _marketSelected(
      BuildContext context, MarketDropdownViewmodel viewmodel) {
    context.read<MarketCubit>().selectMarket(viewmodel.toMarket());
  }

  void _assetSelected(BuildContext context, AssetDropdownViewmodel viewmodel) {
    context.read<AssetCubit>().selectAsset(viewmodel.toAsset());
  }

  Future<List<Asset>> _revealLoader(BuildContext context, Market market) async {
    return context.read<AssetRepository>().loadAssets(market);
  }
}
