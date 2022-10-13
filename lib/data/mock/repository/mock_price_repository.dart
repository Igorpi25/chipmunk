import 'package:chipmunk/data/mock/model/mock_price.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';

const _delay = Duration(seconds: 1);

class MockPriceRepository extends PriceRepository {
  @override
  Stream<Price> tick(Asset asset) {
    return Stream.periodic(_delay, (_) => MockPrice(_.toDouble(), asset));
  }
}