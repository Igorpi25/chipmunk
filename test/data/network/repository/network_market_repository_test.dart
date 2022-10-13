import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_market_repository.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/model/symbol.dart';
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
  given('NetworkMarketRepository', () {
    final mockService = _ActiveSymbolsNetworkService();
    final networkUtil = NetworkUtil(mockService);
    final repository = NetworkMarketRepository(networkUtil);

    const mockMarket = Market('Forex', 'Forex');

    when('NetworkMarketRepository.loadMarkets', () {
      final Future<List<Market>> markets = repository.loadMarkets();
      then('return future of List', () => expect(markets, completion(isList)),
          and: {
            'list contains Market(Forex,Forex)': () =>
                expect(markets, completion(contains(mockMarket))),
          });
    });
  });
}
