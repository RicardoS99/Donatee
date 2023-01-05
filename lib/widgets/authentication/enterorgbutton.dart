import 'package:flutter/material.dart';

class EnterAsOrgButton extends StatelessWidget {
  const EnterAsOrgButton({
    Key key,
    @required this.istapped,
  }) : super(key: key);

  final bool istapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        elevation: 1.0,
        color: istapped ? Colors.grey[400] : Colors.white,
        child: Center(
            child: Text('Enter as Organization',
                style: TextStyle(color: istapped ? Colors.white :Colors.black)),
          ),
      ),
    );
  }
}
