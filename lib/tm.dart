library tm;

import 'package:flutter/material.dart';
import 'package:tm/data.dart';

class TimeMachine extends StatefulWidget {
  /// The size of Time Machine.
  final Size size;

  /// The background color of Time Machine.
  final Color backgroundColor;

  /// The shape of Cards.
  final ShapeBorder? cardShape;

  /// The visible pages of cards.
  final int? visiblePages;

  /// The data of Time Machine.
  final TMData data;

  const TimeMachine({
    Key? key,
    this.size = const Size(double.infinity, double.infinity),
    this.backgroundColor = Colors.white,
    this.visiblePages = 3,
    this.cardShape,
    required this.data,
  }) : super(key: key);

  /// The first style of Time Machine.
  factory TimeMachine.observatory({
    TMData? data,
    Size? size,
    Color? backgroundColor,
    ShapeBorder? cardShape,
    int? visiblePages,
  }) =>
      TimeMachine(
        data: data ?? TMData.placeholder(),
        size: size!,
        backgroundColor: backgroundColor!,
        cardShape: cardShape,
        visiblePages: visiblePages ?? 3,
      );

  @override
  State<TimeMachine> createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {
  double paddingTop = 32;
  double staggeredDistance = 0;
  int visiblePages = 1;

  /// Build a stacked list of cards,
  /// showing by default the entire contents of the first page
  /// and the headers of next two pages.
  List<Positioned> _buildCards() {
    List<TMCard> data;
    if (widget.data.cards.isEmpty) {
      data = TMData.placeholder().cards;
    } else {
      if (widget.visiblePages != null &&
          widget.data.cards.length > widget.visiblePages!) {
        visiblePages = widget.visiblePages!;
      } else {
        visiblePages =
            widget.data.cards.length > 3 ? 3 : widget.data.cards.length;
      }
      data = widget.data.cards.take(visiblePages).toList();
    }

    staggeredDistance = paddingTop / visiblePages;

    List<Positioned> cards = [];

    for (var i = data.length - 1; i >= 0; i--) {
      double paddingTopOfThisCard = paddingTop + i * staggeredDistance;
      double paddingHorizontalOfThisCard = i * staggeredDistance * 0.6;
      cards.add(Positioned(
        top: paddingTopOfThisCard,
        left: 0,
        right: 0,
        child: TMCardContainer(
          backgroundColor: widget.backgroundColor,
          cardShape: widget.cardShape ??
              ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
          size: widget.size,
          margin: EdgeInsets.symmetric(horizontal: paddingHorizontalOfThisCard),
          child: data[i].content,
        ),
      ));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildCards(),
    );
  }
}

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
