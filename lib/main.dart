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
import 'package:chipmunk/app.dart';

void main() {
  final NetworkService networkService = BinaryNetworkService();
  final NetworkUtil networkUtil = NetworkUtil(networkService);

  final PriceRepository priceRepository = NetworkPriceRepository(networkUtil);
  final AssetRepository assetRepository = NetworkAssetRepository(networkUtil);
  MarketRepository marketRepository = NetworkMarketRepository(networkUtil);

  runApp(App(priceRepository, assetRepository, marketRepository));
}
