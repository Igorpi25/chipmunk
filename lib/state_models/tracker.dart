import 'dart:math';

import 'package:chipmunk/state_models/asset_provider.dart';

class Tracker {
  Tracker(this.markets, this.assetProvider);

  AssetProvider assetProvider;

  String? selectedMarket;
  String? selectedAsset;

  List<String> markets;
  List<String>? get assets {
    if (selectedMarket != null) {
      return assetProvider.getAssets(selectedMarket!);
    } else {
      return null;
    }
  }

  double? get price => (selectedAsset != null) ? Random().nextDouble() : null;

  void selectMarket(String? value) {
    if (value == selectedMarket) {
      return;
    } else if (value == null) {
      selectedMarket = value;
      selectedAsset = null;
    } else if (markets.contains(value)) {
      selectedMarket = value;
      selectedAsset = null;
    } else {
      throw Exception('Invalid argument: $value');
    }
  }

  void selectAsset(String? value) {
    selectedAsset = value;
  }
}
