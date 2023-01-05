import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1800), vsync: this, value: 0.05);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.white,
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                size: MediaQuery.of(context).size.width,
                color: Colors.cyan[700],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
