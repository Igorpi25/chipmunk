import 'package:chipmunk/data/network/mapper/price_mapper.dart';
import 'package:chipmunk/data/network/model/tick.dart';
import 'package:chipmunk/domain/model/price.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  given('tick', () {
    const tick = Tick(1.0, 'subs-id-1.0');
    const price = Price(1.0);

    when('map tick to price', () {
      final tickMappedToPrice = PriceMapper.fromTick(tick);
      then('tickMappedToPrice should be price', () {
        tickMappedToPrice.should.be(price);
      });
    });
  });
}
