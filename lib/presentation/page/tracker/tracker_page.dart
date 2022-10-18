import 'package:chipmunk/presentation/bloc/loader_cubit.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';
import 'package:chipmunk/presentation/page/tracker/view/markets_section.dart';
import 'package:flutter/material.dart';

typedef RevealCubit = LoaderCubit<List<Asset>>;
typedef RevealState = LoaderState<List<Asset>>;
typedef RevealLoadingState = LoadingState<List<Asset>>;
typedef RevealLoadedState = LoadedState<List<Asset>>;

class TrackerPage extends StatelessWidget {
  const TrackerPage(this._markets, this._priceRepository, this._assetRepository,
      {super.key});

  final List<Market> _markets;
  final PriceRepository _priceRepository;
  final AssetRepository _assetRepository;

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
            child: MarketsSection(_markets, _assetRepository, _priceRepository),
          ),
        ),
      ),
    );
  }
}
