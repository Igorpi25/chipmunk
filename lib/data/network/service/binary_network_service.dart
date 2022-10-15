import 'dart:async';
import 'dart:convert';

import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/forget_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinaryNetworkService extends NetworkService {
  static const _endpoint = 'wss://ws.binaryws.com/websockets/v3?app_id=1089';

  final _channel = WebSocketChannel.connect(Uri.parse(_endpoint));

  final _requestStreamController = StreamController<Request>();

  BinaryNetworkService() {
    final stream = _requestStreamController.stream.transform<String>(
        StreamTransformer<Request, String>.fromHandlers(
            handleData: _handleRequestData));
    _channel.sink.addStream(stream);
  }

  @override
  StreamSink<Request> get sink => _requestStreamController.sink;

  @override
  Stream<Response> get stream => _channel.stream.transform<Response>(
      StreamTransformer<String, Response>.fromHandlers(
          handleData: _handleStringData));

  void _handleRequestData(Request request, EventSink<String> sink) {
    final json = jsonEncode(request);
    sink.add(json);
  }

  void _handleStringData(String message, EventSink<Response> sink) {
    final Map<String, dynamic> messageMap = jsonDecode(message);

    if (messageMap.containsKey('error')) {
      throw Exception(
          'BinaryService handleMessage error: ${messageMap['error'].toString()}');
    }

    final msgType = messageMap['msg_type'];

    if (msgType == 'active_symbols') {
      sink.add(ActiveSymbolsResponse.fromJson(messageMap));
    } else if (msgType == 'tick') {
      sink.add(TicksResponse.fromJson(messageMap));
    } else if (msgType == 'forget') {
      sink.add(ForgetResponse.fromJson(messageMap));
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _requestStreamController.close();
  }
}
