import 'package:flutter/material.dart';
import 'package:tm/data.dart';

class Pylon {
  static generateCards() {
    return List.generate(
      8,
      (index) => TMCard(
        title: 'title ${index + 1}',
        subTitle: 'subTitle ${index + 1}',
        description: 'description ${index + 1}',
        content: Center(
          child: Text('content ${index + 1}'),
        ),
      ),
    );
  }
}
