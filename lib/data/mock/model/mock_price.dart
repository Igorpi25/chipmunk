import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/model/price.dart';

class MockPrice extends Price {
  const MockPrice(super.value, this.asset);
  final Asset asset;

  @override
  List<Object?> get props => [value, asset];
}
