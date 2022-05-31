library tm;

import 'package:flutter/material.dart';

class TimeMachine extends StatefulWidget {
  const TimeMachine({
    Key? key,
    this.size = const Size(double.infinity, double.infinity),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Size size;
  final Color backgroundColor;

  factory TimeMachine.observatory() {
    return const TimeMachine();
  }

  @override
  State<TimeMachine> createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        width: widget.size.width,
        height: widget.size.height,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
    );
  }
}
