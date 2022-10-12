import 'package:chipmunk/domain/model/market.dart';

abstract class MarketRepository {
  Future<List<Market>> loadMarkets();
}
