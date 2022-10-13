import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/domain/repository/asset_repository.dart';

class NetworkAssetRepository extends AssetRepository {
  NetworkAssetRepository(this._networkUtil);

  final NetworkUtil _networkUtil;

  @override
  Future<List<Asset>> loadAssets(Market market) {
    return _networkUtil.getAssets(market);
  }
}
