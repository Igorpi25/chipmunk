import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/domain/model/price.dart';

class NetworkService {
  final stream = Stream.fromIterable([const Price(1.0)]);

  void send(Request request) {}
}
