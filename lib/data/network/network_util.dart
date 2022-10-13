import 'package:chipmunk/data/network/mapper/price_mapper.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkUtil {
  NetworkUtil(this._networkService);
  final NetworkService _networkService;

  Stream<Price> getTickStream(Asset asset) {
    final TickRequest tickRequest = TickRequest(asset.id);
    _networkService.send(tickRequest);

    return _networkService.stream
        .skipWhile((response) => response is! TicksResponse)
        .map<TicksResponse>((response) => response as TicksResponse)
        .map<Price>((tickResponse) => PriceMapper.fromTick(tickResponse.tick));
  }

  Future<List<Market>> getMarkets() {
    const markets = ['Forex', 'HKS', 'Yandex', 'Nasa'];
    const delay = Duration(seconds: 1);

    return Future.delayed(
        delay, () => markets.map((name) => Market(name, name)).toList());
  }
}
