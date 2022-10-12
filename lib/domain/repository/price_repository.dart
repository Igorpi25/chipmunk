import 'package:chipmunk/domain/model/price.dart';
import 'package:chipmunk/domain/model/asset.dart';

abstract class PriceRepository {
  Stream<Price> tick(Asset asset);
}
