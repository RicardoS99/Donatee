import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown(
      {Key key, this.child, this.labelText, this.valueText, this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: TextStyle(
            color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText,
                style: TextStyle(color: Colors.black, fontSize: 22)),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
