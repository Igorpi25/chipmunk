import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_asset_repository.dart';
import 'package:chipmunk/data/network/repository/network_market_repository.dart';
import 'package:chipmunk/data/network/repository/network_price_repository.dart';
import 'package:chipmunk/data/network/service/binary_network_service.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';
import 'package:chipmunk/domain/repository/market_repository.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:chipmunk/presentation/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final NetworkService networkService = BinaryNetworkService();
  final NetworkUtil networkUtil = NetworkUtil(networkService);

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<MarketRepository>(
          create: (_) => NetworkMarketRepository(networkUtil)),
      RepositoryProvider<AssetRepository>(
          create: (_) => NetworkAssetRepository(networkUtil)),
      RepositoryProvider<PriceRepository>(
          create: (_) => NetworkPriceRepository(networkUtil)),
    ],
    child: const App(),
  ));
}
