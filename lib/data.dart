import 'package:flutter/material.dart';

/// Data needed by Time Machine.
class TMData {
  final List<TMCard> cards;

  const TMData({
    required this.cards,
  });

  /// It can be used to experience how the data is presented.
  factory TMData.placeholder() => const TMData(
        cards: [
          TMCard(
            title: 'Title',
            subTitle: 'SubTitle',
            description: 'Description',
            content: Center(child: Text('Content')),
          ),
        ],
      );
}

/// One of the cards in Time Machine.
class TMCard {
  final String title;
  final String subTitle;
  final String description;
  final Widget content;

  const TMCard({
    this.title = '',
    this.subTitle = '',
    this.description = '',
    this.content = const SizedBox(),
  });
}
