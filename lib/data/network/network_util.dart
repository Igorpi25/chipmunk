import 'package:chipmunk/data/network/mapper/price_mapper.dart';
import 'package:chipmunk/data/network/mapper/symbol_mapper.dart';
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
    // Send request to service
    final TickRequest tickRequest = TickRequest(asset.id);
    _networkService.send(tickRequest);

    // Hook Tick's from service and map to Price
    return _networkService.stream
        .skipWhile((response) => response is! TicksResponse)
        .map<TicksResponse>((response) => response as TicksResponse)
        .map<Price>((tickResponse) => PriceMapper.fromTick(tickResponse.tick));
  }

  Future<List<Market>> getMarkets() async {
    // Send request to service
    const ActiveSymbolsRequest tickRequest =
        ActiveSymbolsRequest(productType: ProductType.basic);
    _networkService.send(tickRequest);

    // Hook response from service
    ActiveSymbolsResponse response = await _networkService.stream
        .skipWhile((response) => response is! ActiveSymbolsResponse)
        .map<ActiveSymbolsResponse>(
            (response) => response as ActiveSymbolsResponse)
        .first;

    // Transfrom List<Symbols> to List<Market>
    return response.symbols.fold<List<Market>>(
        [],
        (markets, symbol) =>
            markets.any((market) => market.id == symbol.marketName)
                ? markets
                : [...markets, MarketMapper.fromSymbol(symbol)]);
  }
}
