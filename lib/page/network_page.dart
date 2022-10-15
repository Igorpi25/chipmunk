import 'dart:convert';

import 'package:chipmunk/data/network/model/tick.dart';
import 'package:chipmunk/data/network/request/active_symbols_request.dart';
import 'package:chipmunk/data/network/request/forget_request.dart';
import 'package:chipmunk/data/network/request/request.dart';
import 'package:chipmunk/data/network/request/tick_request.dart';
import 'package:chipmunk/data/network/response/active_symbols_response.dart';
import 'package:chipmunk/data/network/model/symbol.dart';
import 'package:chipmunk/data/network/response/forget_response.dart';
import 'package:chipmunk/data/network/response/response.dart';
import 'package:chipmunk/data/network/response/ticks_response.dart';
import 'package:chipmunk/data/network/service/binary_network_service.dart';
import 'package:flutter/material.dart';

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
    _networkService.sink.add(request);
  }

  final _networkService = BinaryNetworkService();
  // final _networkService = MockNetworkService();

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
                  stream: _networkService.stream,
                  builder: (context, snapshot) {
                    final Response? response = snapshot.data;
                    if (response != null) {
                      if (response is ActiveSymbolsResponse) {
                        return _displaySymbols(response.symbols);
                      } else if (response is TicksResponse) {
                        final Tick tick = response.tick;

                        _lastTickSubscriptionId = tick.subscriptionId;

                        return _displayTick(tick);
                      } else if (response is ForgetResponse) {
                        return Text(response.toString());
                      } else {
                        return Text('unknown msg_type: ${response.type}');
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
    _networkService.dispose();
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
