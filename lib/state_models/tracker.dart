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
    if (value == selectedMarket) return;

    selectedMarket = value;
    selectedAsset = null;
  }

  void selectAsset(String? value) {
    selectedAsset = value;
  }
}
