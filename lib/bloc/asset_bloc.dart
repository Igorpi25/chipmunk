import 'package:chipmunk/repositories/asset_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_state.dart';
part 'asset_event.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository _assetRepository;
  final String _market;
  // TODO perhaps move repository from Bloc to BlocProvider?
  late List<String> _assets;

  AssetBloc(this._assetRepository, this._market) : super(AssetsLoading()) {
    on<LoadAssets>(_onLoadAssets);
    on<SelectAsset>(_onSelectAsset);
  }

  Future<void> _onLoadAssets(LoadAssets event, Emitter<AssetState> emit) async {
    _assets = await _assetRepository.loadAssets(_market);
    emit(AssetsLoaded(_assets));
  }

  Future<void> _onSelectAsset(
      SelectAsset event, Emitter<AssetState> emit) async {
    final String asset = event.asset;
    emit(AssetSelected(asset, _assets));
  }
}
