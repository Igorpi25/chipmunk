import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> list;
  final String? dropdownValue;
  final String hint;
  final Function(String?) callback;

  const DropdownWidget(this.list, this.hint, this.dropdownValue, this.callback,
      {super.key});

  @override
  State<StatefulWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(widget.hint),
      value: widget.dropdownValue,
      isExpanded: true,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          //widget.dropdownValue = value;
          widget.callback(value);
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
