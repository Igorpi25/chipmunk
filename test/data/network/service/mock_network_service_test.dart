import 'package:chipmunk/data/network/model/tick.dart';
import 'package:chipmunk/data/network/model/symbol.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';

import 'mock_network_service.dart';

void main() async {
  given('NetworkService', () {
    final NetworkService networkService = MockNetworkService();

    when('send TickRequest', () {
      const TickRequest tickRequest = TickRequest('aud-jpy-id');
      networkService.send(tickRequest);
      then('responds mocked tics)', () {
        expect(
            networkService.stream,
            emitsInOrder([
              const TicksResponse(Tick(1.0, 'subscriptionId-1'), 'tick'),
              const TicksResponse(Tick(2.0, 'subscriptionId-1'), 'tick'),
              const TicksResponse(Tick(3.0, 'subscriptionId-1'), 'tick'),
            ]));
      });
    });
  });

  given('NetworkService', () {
    final NetworkService networkService = MockNetworkService();

    when('send ActiveSymbolsRequest', () {
      const ActiveSymbolsRequest request = ActiveSymbolsRequest();
      networkService.send(request);
      then('responds ActiveSymbolsResponse)', () {
        expect(
            networkService.stream,
            emitsInOrder([
              const ActiveSymbolsResponse(
                [
                  Symbol('Forex', 'Forex', 'AUD/JPY', 'AUD/JPY'),
                  Symbol('Forex', 'Forex', 'RUB/CNY', 'RUB/CNY'),
                  Symbol('HKS', 'HKS', 'CNY/USD', 'CNY/USD'),
                  Symbol('HKS', 'HKS', 'Rice/Wheat', 'Rice/Wheat'),
                ],
                'active_symbols',
              ),
            ]));
      });
    });
  });
}
