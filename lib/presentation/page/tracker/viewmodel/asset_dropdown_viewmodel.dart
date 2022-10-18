import 'package:chipmunk/domain/model/asset.dart';
import 'package:equatable/equatable.dart';

class AssetDropdownViewmodel extends Equatable {
  AssetDropdownViewmodel.from(Asset market)
      : name = market.name,
        id = market.id;

  final String name, id;

  Asset toAsset() => Asset(id, name);

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [name, id];
}
