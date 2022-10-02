import 'package:flutter/material.dart';

import 'package:chipmunk/widgets/dropdown_widget.dart';

import '../state_models/tracker.dart';

class TrackerPage extends StatefulWidget {
  final Tracker tracker;
  const TrackerPage(this.tracker, {super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  _TrackerPageState();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownWidget(
                  widget.tracker.markets,
                  "Select market",
                  widget.tracker.selectedMarket,
                  (_) => setState(() => widget.tracker.selectMarket(_)),
                ),
                DropdownWidget(
                  widget.tracker.assets,
                  "Select asset",
                  widget.tracker.selectedAsset,
                  (_) => setState(() => widget.tracker.selectAsset(_)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 16),
                    alignment: AlignmentDirectional.center,
                    child: widget.tracker.price == null
                        ? const CircularProgressIndicator()
                        : Text(widget.tracker.price?.toStringAsFixed(2) ?? ''),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
