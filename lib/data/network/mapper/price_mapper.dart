import 'package:chipmunk/data/network/model/tick.dart';
import 'package:chipmunk/domain/model/price.dart';

class PriceMapper {
  static Price fromTick(Tick tick) {
    return Price(tick.quote);
  }
}
