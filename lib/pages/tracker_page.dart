import 'package:flutter/material.dart';

import 'package:chipmunk/widgets/dropdown_widget.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  String engageValue = "";
  String? selectedMarket, selectedAsset;

  List<String> _getMarketList() {
    return ['Forex', 'HKS', 'Yandex', 'Nasa'];
  }

  List<String> _getAssetList() {
    return (selectedMarket != null)
        ? ['AUD/JPY', 'RUB/CNY', 'TCP/IP', 'USD/TNG']
        : [];
  }

  void _setMarket(String? value) {
    setState(() {
      selectedMarket = value;
      selectedAsset = null;
    });
  }

  void _setAsset(String? value) {
    setState(() {
      selectedAsset = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Price Tracker"),
      ),
      body: Align(
        alignment: AlignmentDirectional.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownWidget(
                  _getMarketList(),
                  "Select market",
                  selectedMarket,
                  _setMarket,
                ),
                DropdownWidget(
                  _getAssetList(),
                  "Select asset",
                  selectedAsset,
                  _setAsset,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 16),
                    alignment: AlignmentDirectional.center,
                    child: ((selectedMarket != null) && (selectedAsset != null))
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
