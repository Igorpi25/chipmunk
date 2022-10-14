import 'package:chipmunk/data/network/mapper/price_mapper.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/cache_service.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkUtil {
  NetworkUtil(this._networkService);

  final NetworkService _networkService;
  final _cacheService = CacheService();

  Stream<Price> getTickStream(Asset asset) {
    _sendTickRequest(asset);

    final ticksStream = _hookTickResponse();

    final pricesStream = ticksStream
        .map<Price>((tickResponse) => PriceMapper.fromTick(tickResponse.tick));

    return pricesStream;
  }

  Future<List<Market>> getMarkets() async {
    if (_cacheService.isCached) {
      return _cacheService.getMarkets();
    }

    _sendActiveSymbolsRequest();

    final response = await _hookActiveSymbolsResponse();

    _cacheService.setSymbols(response.symbols);

    return _cacheService.getMarkets();
  }

  Future<List<Asset>> getAssets(Market market) async {
    if (_cacheService.isCached) {
      return _cacheService.getAssets(market.id);
    }

    _sendActiveSymbolsRequest();

    final response = await _hookActiveSymbolsResponse();

    _cacheService.setSymbols(response.symbols);

    return _cacheService.getAssets(market.id);
  }

  void _sendTickRequest(Asset asset) {
    final TickRequest tickRequest = TickRequest(asset.id);
    _networkService.send(tickRequest);
  }

  void _sendActiveSymbolsRequest() {
    const ActiveSymbolsRequest tickRequest =
        ActiveSymbolsRequest(productType: ProductType.basic);
    _networkService.send(tickRequest);
  }

  Stream<TicksResponse> _hookTickResponse() {
    return _networkService.stream
        .skipWhile((response) => response is! TicksResponse)
        .map<TicksResponse>((response) => response as TicksResponse);
  }

  Future<ActiveSymbolsResponse> _hookActiveSymbolsResponse() {
    return _networkService.stream
        .skipWhile((response) => response is! ActiveSymbolsResponse)
        .map<ActiveSymbolsResponse>(
            (response) => response as ActiveSymbolsResponse)
        .first;
  }
}
