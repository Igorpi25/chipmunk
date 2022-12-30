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
import 'package:web_socket_channel/web_socket_channel.dart';

const _endpoint = 'wss://ws.binaryws.com/websockets/v3?app_id=1089';

void main() {
  
  final WebSocketChannel webSocketChannel = WebSocketChannel.connect(Uri.parse(_endpoint));
  final NetworkService networkService = BinaryNetworkService(webSocketChannel);
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
