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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _floatingButton(_messageActiveSymbols, const Icon(Icons.list)),
          Container(
            width: 20,
          ),
          _floatingButton(_messageTick, const Icon(Icons.send)),
          Container(
            width: 10,
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
}
