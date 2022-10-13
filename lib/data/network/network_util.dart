import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkUtil {
  Stream<Price> getTickStream(Asset asset) {
    return Stream.value(const Price(1.0));
  }
}
