import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/market.dart';

abstract class AssetRepository {
  Future<List<Asset>> loadAssets(Market market);
}
