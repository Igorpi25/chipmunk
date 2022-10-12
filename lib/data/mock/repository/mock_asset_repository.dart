import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';

const _assetsMap = {
  'Forex': ['AUD/JPY', 'RUB/CNY', 'TCP/IP', 'USD/TNG'],
  'HKS': ['CNY/USD', 'Rice/Wheat', 'Gas/Oil'],
  'Yandex': ['TCP/IP', 'TL/NR', 'UDP', 'HTTPS', 'SSL'],
  'Nasa': ['MKS', 'Apollon', 'Starfleet', 'Union']
};

List<Asset> _getAssetsUtil(Market market) {
  final List<String>? assetsNames = _assetsMap[market.id];

  if (assetsNames != null) {
    return assetsNames.map((name) => Asset(name, name)).toList();
  } else {
    throw Exception('Invalid market: $market');
  }
}

const _delay = Duration(seconds: 1);

class MockAssetRepository extends AssetRepository {
  @override
  Future<List<Asset>> loadAssets(Market market) =>
      Future.delayed(_delay, () => _getAssetsUtil(market));
}
