import 'dart:convert';

import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/response/forget_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';

class ResponseFactory {
  static Response fromMessage(dynamic message) {
    final Map<String, dynamic> messageMap = jsonDecode(message);

    if (messageMap.containsKey('error')) {
      throw Exception(
          'BinaryService handleMessage error: ${messageMap['error'].toString()}');
    }

    final msgType = messageMap['msg_type'];

    if (msgType == 'active_symbols') {
      return ActiveSymbolsResponse.fromJson(messageMap);
    } else if (msgType == 'tick') {
      return TicksResponse.fromJson(messageMap);
    } else if (msgType == 'forget') {
      return ForgetResponse.fromJson(messageMap);
    }

    return _UnknownResponse(msgType);
  }
}

class _UnknownResponse extends Response {
  const _UnknownResponse(super.type);
}
