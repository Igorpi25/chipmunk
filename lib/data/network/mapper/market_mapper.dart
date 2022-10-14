import 'package:chipmunk/data/network/model/symbol.dart';
import 'package:chipmunk/domain/model/market.dart';

class MarketMapper {
  static Market fromSymbol(Symbol symbol) {
    return Market(symbol.market, symbol.marketName);
  }
}
