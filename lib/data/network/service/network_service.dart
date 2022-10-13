import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/response/response.dart';

abstract class NetworkService {
  Stream<Response> get stream;
  void send(Request request);
}
