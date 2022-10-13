import 'package:chipmunk/data/network/network_util.dart';
import 'package:chipmunk/data/network/repository/network_price_repository.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';

void main() async {
  given('repository', () {
    final networkService = NetworkService();
    final networkUtil = NetworkUtil(networkService);
    final repository = NetworkPriceRepository(networkUtil);
    const asset = Asset('aud-jpy-id', 'AUD/JPY');

    when('repository tick', () {
      final stream = repository.tick(asset);
      then('expect stream emits Price(1.0)', () {
        expect(
            stream,
            emitsInOrder([
              const Price(1.0),
            ]));
      });
    });
  });
}
