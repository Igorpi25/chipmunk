import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/presentation/page/tracker/bloc/asset_cubit.dart';
import 'package:chipmunk/ui_kit/dropdown.dart';
import 'package:chipmunk/presentation/page/tracker/view/price_section.dart';
import 'package:chipmunk/presentation/page/tracker/viewmodel/asset_dropdown_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetsSection extends StatelessWidget {
  const AssetsSection(this._assets, {super.key});

  final List<Asset> _assets;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(_assets),
      create: (_) => AssetCubit(_assets),
      child: BlocBuilder<AssetCubit, AssetState>(
        builder: (context, state) {
          if (state is AssetsLoaded) {
            return _revealedAssetSection(context, state);
          }
          if (state is AssetSelected) {
            return Column(
              children: [
                _statedAssetSection(context, state),
                PriceSection(state.asset),
              ],
            );
          }
          throw Exception('Unknown state in AssetBloc: $state');
        },
      ),
    );
  }

  Widget _revealedAssetSection(BuildContext context, AssetsLoaded state) {
    return RevealedDropdown<AssetDropdownViewmodel>(
        state.assets
            .map((asset) => AssetDropdownViewmodel.from(asset))
            .toList(),
        'Select asset',
        (_) => _assetSelected(context, _));
  }

  Widget _statedAssetSection(BuildContext context, AssetSelected state) {
    return StatedDropdown<AssetDropdownViewmodel>(
        state.assets
            .map((asset) => AssetDropdownViewmodel.from(asset))
            .toList(),
        AssetDropdownViewmodel.from(state.asset),
        (_) => _assetSelected(context, _));
  }

  void _assetSelected(BuildContext context, AssetDropdownViewmodel viewmodel) {
    context.read<AssetCubit>().selectAsset(viewmodel.toAsset());
  }
}
