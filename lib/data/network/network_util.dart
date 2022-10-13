import 'package:chipmunk/data/network/mapper/asset_mapper.dart';
import 'package:chipmunk/data/network/mapper/price_mapper.dart';
import 'package:chipmunk/data/network/mapper/market_mapper.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkUtil {
  NetworkUtil(this._networkService);

  final NetworkService _networkService;

  Stream<Price> getTickStream(Asset asset) {
    // Send request
    _sendTickRequest(asset);

    // Hook Tick's from service
    final ticksStream = _hookTickResponse();

    // Map ticks to prices
    final pricesStream = ticksStream
        .map<Price>((tickResponse) => PriceMapper.fromTick(tickResponse.tick));

    return pricesStream;
  }

  Future<List<Market>> getMarkets() async {
    // Send request to service
    _sendActiveSymbolsRequest();

    // Wait response from service
    final response = await _hookActiveSymbolsResponse();

    // Transfrom List<Symbols> to List<Market>
    return response.symbols.fold<List<Market>>(
        [],
        (markets, symbol) =>
            markets.any((market) => market.id == symbol.marketName)
                ? markets
                : [...markets, MarketMapper.fromSymbol(symbol)]);
  }

  Future<List<Asset>> getAssets(Market market) async {
    // Send request to service
    _sendActiveSymbolsRequest();

    // Wait response from service
    final response = await _hookActiveSymbolsResponse();

    // Transfrom List<Symbols> to List<Asset>
    return response.symbols.fold<List<Asset>>(
        [],
        (assets, symbol) => (symbol.market == market.id)
            ? [...assets, AssetMapper.fromSymbol(symbol)]
            : assets);
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
