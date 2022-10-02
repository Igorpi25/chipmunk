import 'package:chipmunk/state_models/asset_provider.dart';
import 'package:chipmunk/state_models/tracker.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAssetProvider implements AssetProvider {
  @override
  List<String> getAssets(String market) {
    switch (market) {
      case 'Forex':
        return ['AUD/JPY', 'RUB/CNY', 'TCP/IP', 'USD/TNG'];
      case 'HKS':
        return ['CNY/USD', 'Rice/Wail', 'Gas/Oil'];
      case 'Yandex':
        return ['TCP/IP', 'TL/NR', 'UDP', 'HTTPS', 'SSL'];
      case 'Nasa':
        return ['MKS', 'Apollon', 'Starfleet', 'Union'];
      default:
        throw Exception('Invalid argument: $market');
    }
  }
}

void main() {
  AssetProvider mockAssetProvider = MockAssetProvider();
  mockMarkets() => ['Forex', 'HKS', 'Yandex', 'Nasa'];
  late Tracker tracker;

  setUp(() {
    tracker = Tracker(mockMarkets(), mockAssetProvider);
  });

  test('No market and asset selected initially', () {
    expect(tracker.selectedMarket, isNull);
    expect(tracker.selectedAsset, isNull);
  });

  test('List of markets available initially', () {
    expect(tracker.markets, isNotNull);
  });

  test('List of assets initially is null', () {
    expect(tracker.assets, isNull);
  });

  test('Price is null initially', () {
    expect(tracker.price, null);
  });

  test('Market selecting', () {
    expect(tracker.selectedMarket, isNull);

    tracker.selectMarket('Forex');
    expect(tracker.selectedMarket, 'Forex');
  });

  test('Market null-value selecting', () {
    expect(tracker.selectedMarket, isNull);

    tracker.selectMarket(null);
    expect(tracker.selectedMarket, isNull);
  });

  test('List of assets is null if selected market null', () {
    // Before & Act
    tracker.selectMarket(null);

    // After
    expect(tracker.assets, isNull);
  });

  test('List of assets is not null after market selected', () {
    // Before
    expect(tracker.assets, isNull);

    // Act
    tracker.selectMarket('Forex');

    // After
    expect(tracker.assets, isNotNull);
  });

  test('Selected asset is null after select market', () {
    // Act
    tracker.selectMarket('Forex');

    // After
    expect(tracker.selectedAsset, isNull);
  });

  test('Asset selecting', () {
    // Before
    tracker.selectMarket('Forex');
    expect(tracker.selectedAsset, isNull);

    // Act
    tracker.selectAsset('AUD/JPY');

    // After
    expect(tracker.selectedAsset, 'AUD/JPY');
  });

  test('Selected asset is null after selected market changed', () {
    // Before
    tracker.selectMarket('Forex');
    tracker.selectAsset('AUD/JPY');
    expect(tracker.selectedAsset, isNotNull);

    // Act
    tracker.selectMarket('Yandex');

    // After
    expect(tracker.selectedAsset, isNull);
  });

  test('List of assets changed after selected market changed', () {
    // Before
    tracker.selectMarket('Forex');
    final assetsBefore = tracker.assets;

    // Act
    tracker.selectMarket('Yandex');

    // After
    final assetsAfter = tracker.assets;
    expect(assetsBefore, isNot(equals(assetsAfter)));
  });

  test('List of assets not changed if select same market again', () {
    // Before
    tracker.selectMarket('Forex');
    final assetsBefore = tracker.assets;

    // Act
    tracker.selectMarket('Forex');

    // After
    final assetsAfter = tracker.assets;
    expect(assetsBefore, equals(assetsAfter));
  });

  test('Selected asset not changed if select same market again', () {
    // Before
    tracker.selectMarket('Forex');
    tracker.selectAsset('AUD/JPY');
    final selectedAssetBefore = tracker.selectedAsset;

    // Act
    tracker.selectMarket('Forex');

    // After
    final selectedAssetAfter = tracker.selectedAsset;
    expect(selectedAssetBefore, equals(selectedAssetAfter));
  });

  test('Price is null initially', () {
    expect(tracker.price, isNull);
  });

  test('Price is null if market selected but asset not yet', () {
    tracker.selectMarket('Forex');

    expect(tracker.price, isNull);
  });

  test('Price is not null if asset selected', () {
    tracker.selectMarket('Forex');
    tracker.selectAsset('AUD/JPY');

    expect(tracker.price, isNotNull);
  });

  test('Price is null after market changed (because asset should be null)', () {
    // Before
    tracker.selectMarket('Forex');
    tracker.selectAsset('AUD/JPY');
    expect(tracker.price, isNotNull);

    // Act
    tracker.selectMarket('Yandex');

    // After
    expect(tracker.price, isNull);
  });
}
