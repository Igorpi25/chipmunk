import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/market_repository.dart';

const _markets = ['Forex', 'HKS', 'Yandex', 'Nasa'];
const _delay = Duration(seconds: 1);

List<Market> _getMarketsUtil() {
  return _markets.map((name) => Market(name, name)).toList();
}

class MockMarketRepository extends MarketRepository {
  @override
  Future<List<Market>> loadMarkets() =>
      Future.delayed(_delay, () => _getMarketsUtil());
}
