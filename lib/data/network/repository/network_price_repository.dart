import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/domain/model/price.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';

class NetworkPriceRepository extends PriceRepository {
  NetworkPriceRepository(this._networkUtil);

  final NetworkUtil _networkUtil;

  @override
  Stream<Price> startTicking(Asset asset) {
    return _networkUtil.getTickStream(asset);
  }

  @override
  void stopTicking(Asset asset) {
    _networkUtil.forgetTick(asset);
  }
}
