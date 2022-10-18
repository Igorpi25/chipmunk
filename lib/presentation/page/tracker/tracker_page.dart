import 'package:chipmunk/domain/model/market.dart';
import 'package:chipmunk/presentation/page/tracker/view/markets_section.dart';
import 'package:flutter/material.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage(this._markets, {super.key});

  final List<Market> _markets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Price Tracker"),
      ),
      body: Align(
        alignment: AlignmentDirectional.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MarketsSection(_markets),
          ),
        ),
      ),
    );
  }
}
