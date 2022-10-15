import 'dart:async';

import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';

abstract class MockNetworkService<T> extends NetworkService {
  MockNetworkService() {
    _requestStreamController.stream.listen((request) {
      if (request is T) {
        _responseStreamController.sink
            .addStream(Stream.fromIterable(getResponses()));
      }
    });
  }

  final _responseStreamController = StreamController<Response>();
  final _requestStreamController = StreamController<Request>();

  @override
  Stream<Response> get stream => _responseStreamController.stream;

  @override
  StreamSink<Request> get sink => _requestStreamController.sink;

  Iterable<Response> getResponses();

  @override
  void dispose() {
    _responseStreamController.close();
    _requestStreamController.close();
  }
}
