import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_asset_repository.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/model/symbol.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';

import '../service/mock_network_service.dart';

class _ActiveSymbolsNetworkService
    extends MockNetworkService<ActiveSymbolsRequest> {
  @override
  Iterable<Response> getResponses() {
    return [
      const ActiveSymbolsResponse(
        [
          Symbol('Forex', 'Forex', 'AUD/JPY', 'AUD/JPY'),
          Symbol('Forex', 'Forex', 'RUB/CNY', 'RUB/CNY'),
          Symbol('HKS', 'HKS', 'CNY/USD', 'CNY/USD'),
          Symbol('HKS', 'HKS', 'Rice/Wheat', 'Rice/Wheat'),
        ],
        'active_symbols',
      )
    ];
  }
}

void main() async {
  given('NetworkAssetRepository', () {
    final mockService = _ActiveSymbolsNetworkService();
    final networkUtil = NetworkUtil(mockService);
    final repository = NetworkAssetRepository(networkUtil);

    const mockMarket = Market('Forex', 'Forex');
    const mockAsset = Asset('AUD/JPY', 'AUD/JPY');

    when('NetworkAssetRepository.loadAssets(Market(Forex, Forex))', () {
      final Future<List<Asset>> assets = repository.loadAssets(mockMarket);
      then('return future of List', () => expect(assets, completion(isList)),
          and: {
            'list contains Asset(AUD/JPY,AUD/JPY)': () =>
                expect(assets, completion(contains(mockAsset))),
          });
    });
  });
}
