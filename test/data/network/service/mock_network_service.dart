import 'dart:async';

import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';

abstract class MockNetworkService<T> extends NetworkService {
  final _streamController = StreamController<Response>();

  StreamSink<Response> _sink() => _streamController.sink;

  @override
  Stream<Response> get stream => _streamController.stream;

  @override
  void send(Request request) {
    if (request is T) {
      _sink().addStream(Stream.fromIterable(getResponses()));
    }
  }

  Iterable<Response> getResponses();

  @override
  void dispose() {
    _streamController.close();
  }
}
