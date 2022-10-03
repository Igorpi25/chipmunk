import 'package:chipmunk/state_models/asset_provider.dart';
import 'package:chipmunk/state_models/tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

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

  group('initially', () {
    test('selected market should be null', () {
      tracker.selectedMarket.should.beNull();
    });

    test('selected asset should be null', () {
      tracker.selectedAsset.should.beNull();
    });

    test("markets shouldn't be null", () {
      tracker.markets.should.not.beNull();
    });

    test('assets should be null', () {
      tracker.assets.should.beNull();
    });

    test('price should be null', () {
      tracker.price.should.beNull();
    });
  });

  group('market select', () {
    setUp(() {
      tracker.selectedMarket.should.beNull();
    });

    test('item contained in markets', () {
      const forex = 'Forex';
      tracker.markets.should.contain(forex);

      // Act
      tracker.selectMarket(forex);

      tracker.selectedMarket.should.be(forex);
    });

    test('item not contained in markets', () {
      const nasdaq = 'Nasdaq';
      tracker.markets.should.not.contain(nasdaq);

      // Act
      Should.throwException(() => tracker.selectMarket(nasdaq));
    });

    test('null', () {
      // Act
      Should.notThrowException(() => tracker.selectMarket(null));

      tracker.selectedMarket.should.beNull();
    });
  });

  group('assets', () {
    setUp(() {
      tracker.selectedMarket.should.beNull();
      tracker.selectedAsset.should.beNull();
    });

    test('is null when market select null', () {
      //Act
      tracker.selectMarket(null);

      tracker.assets.should.beNull();
    });

    test('is not null when market select item contained in markets', () {
      const forex = 'Forex';
      tracker.markets.should.contain(forex);

      // Act
      tracker.selectMarket(forex);

      tracker.assets.should.not.beNull();
    });
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
