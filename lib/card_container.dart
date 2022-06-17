import 'package:flutter/material.dart';

class TMCardContainer extends StatelessWidget {
  final Color backgroundColor;
  final ShapeBorder cardShape;
  final Size size;
  final EdgeInsets margin;
  final Widget child;

  const TMCardContainer({
    super.key,
    required this.backgroundColor,
    required this.cardShape,
    required this.size,
    required this.child,
    this.margin = const EdgeInsets.all(0),
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        constraints: BoxConstraints.expand(
          width: size.width,
          height: size.height,
        ),
        child: Padding(
          padding: margin,
          child: Material(
            color: backgroundColor,
            shape: cardShape,
            elevation: 12,
            shadowColor: Colors.black54,
            child: child,
          ),
        ),
      ),
    );
  }
}
