import 'dart:async';
import 'dart:convert';

import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/forget_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/network_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinaryService extends NetworkService {
  BinaryService();

  static const _endpoint = 'wss://ws.binaryws.com/websockets/v3?app_id=1089';
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse(_endpoint),
  );

  @override
  Stream<Response> get stream => _channel.stream.transform<Response>(
      StreamTransformer<dynamic, Response>.fromHandlers(
          handleData: handleMessage));

  void handleMessage(message, EventSink<Response> sink) {
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
  void send(Request request) {
    final json = jsonEncode(request);
    _channel.sink.add(json);
  }

  @override
  void dispose() {
    _channel.sink.close();
  }
}
