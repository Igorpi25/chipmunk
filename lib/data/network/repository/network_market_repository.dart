import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/market_repository.dart';

class NetworkMarketRepository extends MarketRepository {
  NetworkMarketRepository(this._networkUtil);

  final NetworkUtil _networkUtil;

  @override
  Future<List<Market>> loadMarkets() {
    return _networkUtil.getMarkets();
  }
}
