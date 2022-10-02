import 'package:chipmunk/state_models/asset_provider.dart';
import 'package:chipmunk/state_models/tracker.dart';
import 'package:flutter/material.dart';
import 'pages/tracker_page.dart';

void main() {
  runApp(App());
}

class SampleAssetProvider implements AssetProvider {
  @override
  List<String> getAssets(String market) {
    switch (market) {
      case 'Forex':
        return ['AUD/JPY', 'RUB/CNY', 'TCP/IP', 'USD/TNG'];
      case 'HKS':
        return ['CNY/USD', 'Rice/Wail', 'Gas/Oil'];
      case 'Yandex':
        return ['TCP/IP', 'TL/NR', 'UDP', 'HTTPS', 'SSL'];
      case 'Nasa':
        return ['MKS', 'Apollon', 'Starfleet', 'Union'];
      default:
        throw Exception('Invalid argument: $market');
    }
  }
}

class App extends StatelessWidget {
  App({super.key});

  final AssetProvider assetProvider = SampleAssetProvider();
  final markets = ['Forex', 'HKS', 'Yandex', 'Nasa'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrackerPage(Tracker(markets, assetProvider)),
    );
  }
}
