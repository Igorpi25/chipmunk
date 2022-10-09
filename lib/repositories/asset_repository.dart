const _assetsMap = {
  'Forex': ['AUD/JPY', 'RUB/CNY', 'TCP/IP', 'USD/TNG'],
  'HKS': ['CNY/USD', 'Rice/Wheat', 'Gas/Oil'],
  'Yandex': ['TCP/IP', 'TL/NR', 'UDP', 'HTTPS', 'SSL'],
  'Nasa': ['MKS', 'Apollon', 'Starfleet', 'Union']
};

List<String> _getAssets(String market) {
  final assets = _assetsMap[market];
  if (assets != null) {
    return assets;
  } else {
    throw Exception('Invalid market: $market');
  }
}

const _delay = Duration(seconds: 1);

class AssetRepository {
  Future<List<String>> loadAssets(String market) =>
      Future.delayed(_delay, () => _getAssets(market));
}
