import 'package:chipmunk/domain/model/price.dart';
import 'package:chipmunk/domain/model/asset.dart';

abstract class PriceRepository {
  Stream<Price> startTicking(Asset asset);
  void stopTicking(Asset asset);
}
