import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';
import 'package:chipmunk/presentation/page/tracker/bloc/market_cubit.dart';
import 'package:chipmunk/presentation/page/tracker/view/assets_section.dart';
import 'package:chipmunk/presentation/page/tracker/viewmodel/market_dropdown_viewmodel.dart';
import 'package:chipmunk/presentation/common_bloc/loader_cubit.dart';
import 'package:chipmunk/ui_kit/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef RevealCubit = LoaderCubit<List<Asset>>;
typedef RevealState = LoaderState<List<Asset>>;
typedef RevealLoadingState = LoadingState<List<Asset>>;
typedef RevealLoadedState = LoadedState<List<Asset>>;

class MarketsSection extends StatelessWidget {
  const MarketsSection(this._markets, {super.key});

  final List<Market> _markets;

  AssetRepository _getAssetRepository(BuildContext context) {
    return context.read<AssetRepository>();
  }

  MarketCubit _getMarketCubit(BuildContext context) {
    return context.read<MarketCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MarketCubit>(
      create: (_) => MarketCubit(_markets),
      child: BlocBuilder<MarketCubit, MarketState>(
        builder: (context, state) {
          if (state is MarketsLoaded) {
            return Column(
              children: [
                _marketsLoadedMarketsDropdown(context, state),
                _marketsLoadedAssetsDropdown(context, state),
              ],
            );
          }
          if (state is MarketSelected) {
            return Column(
              children: [
                _marketSelectedMarketsDropdown(context, state),
                _marketSelectedAssetsDropdown(context, state),
              ],
            );
          }
          throw Exception('Unknown state in MarketBloc: $state');
        },
      ),
    );
  }

  Widget _marketsLoadedMarketsDropdown(
      BuildContext context, MarketsLoaded state) {
    return RevealedDropdown<MarketDropdownViewmodel>(
        state.markets
            .map((market) => MarketDropdownViewmodel.from(market))
            .toList(),
        'Select market',
        (_) => _marketSelected(context, _));
  }

  Widget _marketsLoadedAssetsDropdown(
      BuildContext context, MarketsLoaded state) {
    return const PlaceholderDropdown('No assets');
  }

  Widget _marketSelectedMarketsDropdown(
      BuildContext context, MarketSelected state) {
    return StatedDropdown<MarketDropdownViewmodel>(
        state.markets
            .map((market) => MarketDropdownViewmodel.from(market))
            .toList(),
        MarketDropdownViewmodel.from(state.market),
        (_) => _marketSelected(context, _));
  }

  Widget _marketSelectedAssetsDropdown(
      BuildContext context, MarketSelected state) {
    return BlocProvider(
      key: ValueKey(state.market),
      create: (_) =>
          RevealCubit(_getAssetRepository(context).loadAssets(state.market))
            ..load(),
      child: BlocBuilder<RevealCubit, RevealState>(builder: (context, state) {
        if (state is RevealLoadingState) {
          return const PlaceholderDropdown('Assets loading ...');
        }
        if (state is RevealLoadedState) {
          return AssetsSection(state.data);
        }
        throw Exception('Unknown state in RevealCubit: $state');
      }),
    );
  }

  void _marketSelected(
      BuildContext context, MarketDropdownViewmodel viewmodel) {
    _getMarketCubit(context).selectMarket(viewmodel.toMarket());
  }
}
