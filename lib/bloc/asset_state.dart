part of 'asset_bloc.dart';

abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetsLoaded extends AssetState {
  AssetsLoaded(this.assets);

  final List<Asset> assets;

  @override
  List<Object?> get props => [assets];
}

class AssetSelected extends AssetState {
  AssetSelected(this.asset, this.assets);

  final Asset asset;
  final List<Asset> assets;

  @override
  List<Object?> get props => [asset, assets];
}
