const _markets = ['Forex', 'HKS', 'Yandex', 'Nasa'];
const _delay = Duration(seconds: 1);

class MarketRepository {
  Future<List<String>> loadMarkets() => Future.delayed(_delay, () => _markets);
}
