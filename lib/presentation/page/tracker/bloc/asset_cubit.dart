import 'package:chipmunk/domain/model/asset.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  AssetCubit(this._assets) : super(AssetsLoaded(_assets));

  final List<Asset> _assets;

  void selectAsset(Asset asset) => emit(AssetSelected(asset, _assets));
}
