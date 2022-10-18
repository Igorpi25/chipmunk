import 'package:chipmunk/domain/model/asset.dart';
import 'package:chipmunk/domain/repository/price_repository.dart';
import 'package:chipmunk/presentation/page/tracker/bloc/price_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceSection extends StatelessWidget {
  const PriceSection(this._asset, {super.key});

  final Asset _asset;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PriceCubit>(
      key: ValueKey(_asset),
      create: (BuildContext context) =>
          PriceCubit(context.read<PriceRepository>(), _asset)..start(),
      child: BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(top: 16),
            alignment: AlignmentDirectional.center,
            child: () {
              if (state is PriceData) {
                return Text(
                  'Price: ${state.price.value.toStringAsFixed(3)}',
                  style: TextStyle(color: _priceColorByState(state)),
                );
              } else if (state is PriceLoading) {
                return const CircularProgressIndicator();
              }
            }(),
          );
        },
      ),
    );
  }

  Color _priceColorByState(PriceData state) {
    if (state is GrowingValue) return Colors.green;
    if (state is DecreasingValue) return Colors.red;
    if (state is StandingValue) return Colors.grey;

    throw Exception('Unknown PriceValue state');
  }
}
