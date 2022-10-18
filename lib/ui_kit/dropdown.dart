import 'package:flutter/material.dart';

abstract class _Dropdown<T> extends StatelessWidget {
  final List<T>? _list;
  final T? _value;
  final String? _hint;
  final Function(T)? _callback;

  const _Dropdown(this._list, this._value, this._hint, this._callback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      hint: Text(_hint ?? ""),
      value: _value,
      isExpanded: true,
      onChanged: (T? selectedValue) {
        final callback = _callback;
        if (selectedValue != null &&
            selectedValue != _value &&
            callback != null) callback(selectedValue);
      },
      items: _list?.map<DropdownMenuItem<T>>((_) {
        return DropdownMenuItem<T>(
          value: _,
          child: Text(_.toString()),
        );
      }).toList(),
    );
  }
}

class RevealedDropdown<T> extends _Dropdown<T> {
  const RevealedDropdown(List<T> list, String hint, Function(T) callback,
      {super.key})
      : super(list, null, hint, callback);
}

class StatedDropdown<T> extends _Dropdown<T> {
  const StatedDropdown(List<T> list, T value, Function(T) callback, {super.key})
      : super(list, value, null, callback);
}

class PlaceholderDropdown extends _Dropdown {
  const PlaceholderDropdown(String hint, {super.key})
      : super(null, null, hint, null);
}
