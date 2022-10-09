import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_state.dart';
part 'asset_event.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc(this._assets) : super(AssetsLoaded(_assets)) {
    on<SelectAsset>(_onSelectAsset);
  }

  final List<String> _assets;

  Future<void> _onSelectAsset(
      SelectAsset event, Emitter<AssetState> emit) async {
    final String asset = event.asset;
    emit(AssetSelected(asset, _assets));
  }
}
