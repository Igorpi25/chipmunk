part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectAsset extends AssetEvent {
  final Asset asset;

  SelectAsset(this.asset);

  @override
  List<Object?> get props => [asset];
}
