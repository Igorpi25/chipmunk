import 'dart:async';
import 'dart:convert';

import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/response_factory.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinaryNetworkService extends NetworkService {
  // TODO avoid actions in contructor.
  // perhaps better use Adapter/Decorator-pattern?
  BinaryNetworkService(this._channel) {
    _channel.sink.addStream(_getTransfromedStream<Request, dynamic>(
        _controller.stream, _handleOutgoingData));
  }

  final WebSocketChannel _channel;

  final _controller = StreamController<Request>();

  @override
  StreamSink<Request> get sink => _controller.sink;

  @override
  Stream<Response> get stream => _getTransfromedStream<dynamic, Response>(
      _channel.stream, _handleIncomingData);

  Stream<R> _getTransfromedStream<S, R>(
      Stream<S> sourceStream, Function(S, EventSink<R>) dataHandler) {
    return sourceStream.transform<R>(
        StreamTransformer<S, R>.fromHandlers(handleData: dataHandler));
  }

  void _handleOutgoingData(Request request, EventSink<dynamic> sink) {
    final json = jsonEncode(request);
    sink.add(json);
  }

  void _handleIncomingData(dynamic message, EventSink<Response> sink) {
    sink.add(ResponseFactory.fromMessage(message));
  }

  @override
  void dispose() {
    _controller.close();
    _channel.sink.close();
  }
}
