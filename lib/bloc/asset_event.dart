part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAssets extends AssetEvent {
  LoadAssets();

  @override
  List<Object?> get props => [];
}

class SelectAsset extends AssetEvent {
  final String asset;

  SelectAsset(this.asset);

  @override
  List<Object?> get props => [asset];
}
