import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_asset_repository.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';

import '../service/mock_network_service.dart';

void main() async {
  given('NetworkAssetRepository', () {
    final networkService = MockNetworkService();
    final networkUtil = NetworkUtil(networkService);
    final repository = NetworkAssetRepository(networkUtil);

    const market = Market('Forex', 'Forex');

    when('NetworkAssetRepository.loadAssets(Market(Forex, Forex))', () {
      final Future<List<Asset>> assets = repository.loadAssets(market);
      then('return future of List', () => expect(assets, completion(isList)),
          and: {
            'list contains Asset(AUD/JPY,AUD/JPY)': () => expect(assets,
                completion(contains(const Asset('AUD/JPY', 'AUD/JPY')))),
          });
    });
  });
}
