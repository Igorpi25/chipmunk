import 'dart:async';

import 'package:chipmunk/data/network/model/tick.dart';
import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';

class MockNetworkService extends NetworkService {
  final _streamController = StreamController<Response>();

  StreamSink<Response> _sink() => _streamController.sink;

  @override
  Stream<Response> get stream => _streamController.stream;

  @override
  void send(Request request) {
    if (request is TickRequest) {
      _sink().addStream(Stream.fromIterable([
        const TicksResponse(Tick(1.0, 'subscriptionId-1'), 'tick'),
        const TicksResponse(Tick(2.0, 'subscriptionId-1'), 'tick'),
        const TicksResponse(Tick(3.0, 'subscriptionId-1'), 'tick'),
      ]));
    }
  }
}
