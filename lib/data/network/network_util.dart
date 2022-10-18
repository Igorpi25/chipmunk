import 'package:chipmunk/data/network/mapper/price_mapper.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/request/forget_request.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/cache_service.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkUtil {
  NetworkUtil(this._networkService)
      : _broadcaststream = _networkService.stream.asBroadcastStream();

  final Stream<Response> _broadcaststream;
  final NetworkService _networkService;
  // TODO move dependency to contrucor argument, or smth better
  final _cacheService = CacheService();

  Stream<Price> getTickStream(Asset asset) {
    _sendTickRequest(asset);

    final tickResponseStream = _hookTickResponse();

    final pricesStream = tickResponseStream.where((tickResponse) {
      return tickResponse.tick.symbol == asset.id;
    }).map<Price>((tickResponse) => PriceMapper.fromTick(tickResponse.tick));

    return pricesStream;
  }

  void forgetTick(Asset asset) async {
    final tickResponseStream = _hookTickResponse();

    final tickResponse = await tickResponseStream.firstWhere((tickResponse) {
      return tickResponse.tick.symbol == asset.id;
    });

    final subscriptionId = tickResponse.tick.subscriptionId;

    _sendForgetRequest(subscriptionId);
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
    _networkService.sink.add(tickRequest);
  }

  void _sendForgetRequest(String subscriptionId) {
    final ForgetRequest tickRequest = ForgetRequest(subscriptionId);
    _networkService.sink.add(tickRequest);
  }

  void _sendActiveSymbolsRequest() {
    const ActiveSymbolsRequest activeSymbolsRequest =
        ActiveSymbolsRequest(productType: ProductType.basic);
    _networkService.sink.add(activeSymbolsRequest);
  }

  Stream<TicksResponse> _hookTickResponse() {
    return _broadcaststream
        .where((response) => response is TicksResponse)
        .map<TicksResponse>((response) => response as TicksResponse);
  }

  Future<ActiveSymbolsResponse> _hookActiveSymbolsResponse() {
    return _broadcaststream
        .where((response) => response is ActiveSymbolsResponse)
        .map<ActiveSymbolsResponse>(
            (response) => response as ActiveSymbolsResponse)
        .first;
  }
}
