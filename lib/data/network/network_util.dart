import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkUtil {
  NetworkUtil(this._networkService);
  final NetworkService _networkService;

  Stream<Price> getTickStream(Asset asset) {
    final TickRequest tickRequest = TickRequest(asset.id);
    _networkService.send(tickRequest);
    return _networkService.stream;
  }
}
