import 'package:flutter/material.dart';

abstract class _Dropdown extends StatelessWidget {
  final List<String>? _list;
  final String? _value;
  final String? _hint;
  final Function(String)? _callback;

  const _Dropdown(this._list, this._value, this._hint, this._callback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(_hint ?? ""),
      value: _value,
      isExpanded: true,
      onChanged: (String? selectedValue) {
        final callback = _callback;
        if (selectedValue != null &&
            selectedValue != _value &&
            callback != null) callback(selectedValue);
      },
      items: _list?.map<DropdownMenuItem<String>>((_) {
        return DropdownMenuItem<String>(
          value: _,
          child: Text(_),
        );
      }).toList(),
    );
  }
}

class RevealedDropdown extends _Dropdown {
  const RevealedDropdown(
      List<String> list, String hint, Function(String) callback,
      {super.key})
      : super(list, null, hint, callback);
}

class StatedDropdown extends _Dropdown {
  const StatedDropdown(
      List<String> list, String value, Function(String) callback,
      {super.key})
      : super(list, value, null, callback);
}

class PlaceholderDropdown extends _Dropdown {
  const PlaceholderDropdown(String hint, {super.key})
      : super(null, null, hint, null);
}
