import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';

class CustomCupertinoRadio extends StatefulWidget {
  /// CupertinoRadioChoice displays a radio choice widget with cupertino format
  const CustomCupertinoRadio(
      {super.key,
      required this.choices,
      required this.onChange,
      required this.initialKeyValue,
      this.selectedColor = CupertinoColors.systemBlue,
      this.notSelectedColor = CupertinoColors.inactiveGray,
      this.enabled = true,
      this.formField});

  /// Function is called if the user selects another choice
  final Function onChange;

  /// Defines which choice shall be selected initally by key
  final dynamic initialKeyValue;

  /// Contains a map which defines which choices shall be displayed (key => value).
  /// Values are the values displyed in the choices
  final Map<dynamic, String> choices;

  /// The color of the selected radio choice
  final Color selectedColor;

  /// The color of the not selected radio choice(s)
  final Color notSelectedColor;

  /// Defines if the widget shall be enabled (clickable) or not
  final bool enabled;

  final FormFieldState<Object?>? formField;

  @override
  CustomCupertinoRadioState createState() => CustomCupertinoRadioState();
}

/// State of the widget
class CustomCupertinoRadioState extends State<CustomCupertinoRadio> {
  dynamic _selectedKey;

  Widget buildSelectionButton(String key, String value,
      {bool selected = false}) {
    return Container(
        child: CupertinoButton(
          disabledColor: selected ? widget.selectedColor : widget.notSelectedColor,
          color: selected ? widget.selectedColor : widget.notSelectedColor,
          padding: const EdgeInsets.all(10.0),
          onPressed: !widget.enabled || selected
            ? null
            : () {
              setState(() {
                _selectedKey = key;
                widget.formField?.didChange(_selectedKey);
              });
              widget.onChange(_selectedKey);
            },
          child: Text(value),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonList = [];
    for (var key in widget.choices.keys) {
      buttonList.add(buildSelectionButton(key, widget.choices[key]!,
          selected: _selectedKey == key));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: buttonList,
        ),
        if (widget.formField != null && widget.formField!.hasError)
          Gaps.v16,
        if (widget.formField != null && widget.formField!.hasError)
          Text(
            widget.formField!.errorText!,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 12,
              color: Colors.red[700],
              height: 0.5,
            ),
          )
      ],
    );
  }
}