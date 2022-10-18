import 'package:chipmunk/domain/model/market.dart';
import 'package:equatable/equatable.dart';

class MarketDropdownViewmodel extends Equatable {
  MarketDropdownViewmodel.from(Market market)
      : name = market.name,
        id = market.id;

  final String name, id;

  Market toMarket() => Market(id, name);

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [name, id];
}
