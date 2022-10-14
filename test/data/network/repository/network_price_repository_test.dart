import 'package:chipmunk/data/network/model/tick.dart';
import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_price_repository.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';

import '../service/mock_network_service.dart';

class _TicksMockNetworkService extends MockNetworkService<TickRequest> {
  @override
  Iterable<Response> getResponses() {
    return [
      const TicksResponse(Tick(1.0, 'subscriptionId-1', 'Forex'), 'tick'),
      const TicksResponse(Tick(2.0, 'subscriptionId-1', 'Forex'), 'tick'),
      const TicksResponse(Tick(3.0, 'subscriptionId-1', 'Forex'), 'tick'),
    ];
  }
}

void main() async {
  given('NetworkPriceRepository', () {
    final networkService = _TicksMockNetworkService();
    final networkUtil = NetworkUtil(networkService);
    final repository = NetworkPriceRepository(networkUtil);
    const asset = Asset('aud-jpy-id', 'AUD/JPY');

    when('NetworkPriceRepository.tick', () {
      final stream = repository.tick(asset);
      then('NetworkPriceRepository.stream emits prices', () {
        expect(
            stream,
            emitsInOrder([
              const Price(1.0),
              const Price(2.0),
              const Price(3.0),
            ]));
      });
    });
  });
}
