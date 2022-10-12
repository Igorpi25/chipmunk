import 'package:chipmunk/domain/model/asset.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_state.dart';
part 'asset_event.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc(this._assets) : super(AssetsLoaded(_assets)) {
    on<SelectAsset>(_onSelectAsset);
  }

  final List<Asset> _assets;

  Future<void> _onSelectAsset(
      SelectAsset event, Emitter<AssetState> emit) async {
    final Asset asset = event.asset;
    emit(AssetSelected(asset, _assets));
  }
}
