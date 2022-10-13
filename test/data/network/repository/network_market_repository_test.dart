import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_market_repository.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';

import '../service/mock_network_service.dart';

void main() async {
  given('NetworkMarketRepository', () {
    final networkService = MockNetworkService();
    final networkUtil = NetworkUtil(networkService);
    final repository = NetworkMarketRepository(networkUtil);

    when('NetworkMarketRepository.loadMarkets', () {
      final Future<List<Market>> markets = repository.loadMarkets();
      then('return future of List', () => expect(markets, completion(isList)),
          and: {
            'list contains Market(Forex,Forex)': () => expect(
                markets, completion(contains(const Market('Forex', 'Forex')))),
          });
    });
  });
}
