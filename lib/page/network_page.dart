import 'dart:convert';

import 'package:chipmunk/network/model/tick.dart';
import 'package:chipmunk/network/request/active_symbols_request.dart';
import 'package:chipmunk/network/request/forget_request.dart';
import 'package:chipmunk/network/request/request.dart';
import 'package:chipmunk/network/request/tick_request.dart';
import 'package:chipmunk/network/response/active_symbols_response.dart';
import 'package:chipmunk/network/model/symbol.dart';
import 'package:chipmunk/network/response/forget_response.dart';
import 'package:chipmunk/network/response/ticks_response.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  String _lastTickSubscriptionId = '';

  Request _tickRequest() => const TickRequest('R_100');
  Request _activeSymbolsRequest() => const ActiveSymbolsRequest(
        productType: ProductType.basic,
      );
  Request _forgetRequest() => ForgetRequest(_lastTickSubscriptionId);

  void _requestServer(Request request) {
    final String json = jsonEncode(request);
    _channel.sink.add(json);
  }

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=1089'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Playground'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder(
                  stream: _channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final Map<String, dynamic> messageMap =
                          jsonDecode(snapshot.data);

                      if (messageMap.containsKey('error')) {
                        return Text('error: ${messageMap['error'].toString()}');
                      }

                      final msgType = messageMap['msg_type'];

                      if (msgType == 'active_symbols') {
                        final ActiveSymbolsResponse response =
                            ActiveSymbolsResponse.fromJson(messageMap);

                        return _displaySymbols(response.symbols);
                      } else if (msgType == 'tick') {
                        final TicksResponse response =
                            TicksResponse.fromJson(messageMap);

                        final Tick tick = response.tick;

                        _lastTickSubscriptionId = tick.subscriptionId;

                        return _displayTick(tick);
                      } else if (msgType == 'forget') {
                        final ForgetResponse response =
                            ForgetResponse.fromJson(messageMap);

                        return Text(response.toString());
                      } else {
                        return Text('unknown msg_type: $msgType');
                      }
                    }

                    return const Text('snapshot hasn`t data');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _floatingButton(_activeSymbolsRequest, const Icon(Icons.list)),
          Container(
            width: 16,
          ),
          _floatingButton(_tickRequest, const Icon(Icons.send)),
          Container(
            width: 8,
          ),
          _floatingButton(_forgetRequest, const Icon(Icons.close)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  Widget _floatingButton(Request Function() request, Icon icon) {
    final String message = jsonEncode(request());

    return FloatingActionButton(
      onPressed: () => _requestServer(request()),
      tooltip: 'Send: $message',
      child: icon,
    );
  }

  Widget _displaySymbols(List<Symbol> symbols) {
    return Column(
        children:
            symbols.map<Widget>((symbol) => Text(symbol.toString())).toList());
  }

  Widget _displayTick(Tick tick) {
    return Text(tick.toString());
  }
}
