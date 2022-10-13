import 'package:chipmunk/data/network/model/symbol.dart';
import 'package:chipmunk/domain/model/asset.dart';

class AssetMapper {
  static Asset fromSymbol(Symbol symbol) {
    return Asset(symbol.symbol, symbol.symbolName);
  }
}
