import 'package:chipmunk/data/network/mapper/asset_mapper.dart';
import 'package:chipmunk/data/network/mapper/market_mapper.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/data/network/model/symbol.dart';

class CacheService {
  List<Market>? _markets;
  Map<String, List<Asset>>? _assetsMap;

  List<Asset> getAssets(String market) {
    if (_assetsMap == null) {
      throw Exception('Cache is null: getAssets');
    }

    final List<Asset>? assets = _assetsMap?[market];

    if (assets != null) {
      return assets;
    } else {
      throw Exception('Invalid argument: $market');
    }
  }

  List<Market> getMarkets() {
    final markets = _markets;
    if (markets != null) {
      return markets;
    } else {
      throw Exception('Cache is null: getMarkets');
    }
  }

  void setSymbols(List<Symbol> symbols) {
    final List<Market> markets = [];
    final Map<String, List<Asset>> assetsMap = {};

    for (var symbol in symbols) {
      final asset = AssetMapper.fromSymbol(symbol);

      if (!assetsMap.containsKey(symbol.market)) {
        markets.add(MarketMapper.fromSymbol(symbol));
      }

      assetsMap[symbol.market] = [...?assetsMap[symbol.market], asset];
    }

    _markets = markets;
    _assetsMap = assetsMap;
  }

  bool get isCached => (_markets != null) && (_assetsMap != null);
}
