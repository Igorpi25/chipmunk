import 'dart:convert';

import 'package:chipmunk/network/response/active_symbols_response.dart';
import 'package:chipmunk/network/model/symbol.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  final _messageActiveSymbols =
      '{"active_symbols": "brief", "product_type": "basic"}';
  final _messageTick = '{"ticks":"R_100"}';
  final _messageForget = '{"forget_all":"ticks"}';

  void _sendToServer(String value) {
    _channel.sink.add(value);
  }

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=1089'),
  );

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Playground'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final Map<String, dynamic> messageMap =
                        jsonDecode(snapshot.data);

                    final msgType = messageMap['msg_type'];

                    if (msgType == 'active_symbols') {
                      final ActiveSymbolsResponse activeSymbols =
                          ActiveSymbolsResponse.fromJson(messageMap);

                      return _displaySymbols(activeSymbols.symbols);
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _floatingButton(_messageActiveSymbols, const Icon(Icons.list)),
          Container(
            width: 16,
          ),
          _floatingButton(_messageTick, const Icon(Icons.send)),
          Container(
            width: 8,
          ),
          _floatingButton(_messageForget, const Icon(Icons.close)),
        ],
      ),
    );
  }

  Widget _floatingButton(String message, Icon icon) {
    return FloatingActionButton(
      onPressed: () => _sendToServer(message),
      tooltip: 'Send: $message',
      child: icon,
    );
  }

  Widget _displaySymbols(List<Symbol> symbols) {
    return Column(
        children:
            symbols.map<Widget>((symbol) => Text(symbol.toString())).toList());
  }
}
