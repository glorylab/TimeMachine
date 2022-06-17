library tm;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm/card_container.dart';
import 'package:tm/data.dart';
import 'package:tm/status.dart';

const int defaultVisiblePageCount = 4;

enum MoveType {
  next,
  back,
}

enum MachineType {
  observatory,
}

final statusProvider = StateNotifierProvider<StatusNotifier, TimeMachineStatus>(
    (ref) => StatusNotifier(TimeMachineStatus.init()));

final edgeProvider = Provider((ref) {
  final TimeMachineStatus status = ref.watch(statusProvider);
  if (status.count == 1) {
    return 0;
  } else if (status.count == status.currentIndex + 1) {
    return 1;
  } else if (status.count == 0) {
    return -1;
  }
  return null;
});

class TimeMachine extends StatelessWidget {
  final MachineType type;

  /// The size of Time Machine.
  final Size size;

  /// The background color of Time Machine.
  final Color backgroundColor;

  /// The shape of Cards.
  final ShapeBorder? cardShape;

  /// The visible page count of cards.
  final int? visiblePageCount;

  /// The data of Time Machine.
  final TMData data;

  const TimeMachine(
      {super.key,
      required this.type,
      required this.size,
      required this.backgroundColor,
      this.cardShape,
      this.visiblePageCount,
      required this.data});

  _getTimeMachine() {
    switch (type) {
      default:
        return BaseTimeMachine.observatory(
          size: size,
          backgroundColor: backgroundColor,
          cardShape: cardShape,
          data: data,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: _getTimeMachine());
  }
}

class BaseTimeMachine extends ConsumerStatefulWidget {
  /// The size of Time Machine.
  final Size size;

  /// The background color of Time Machine.
  final Color backgroundColor;

  /// The shape of Cards.
  final ShapeBorder? cardShape;

  /// The visible page count of cards.
  final int? visiblePageCount;

  /// The data of Time Machine.
  final TMData data;

  final TimeMachineController timeMachineController;

  const BaseTimeMachine({
    Key? key,
    this.size = const Size(double.infinity, double.infinity),
    this.backgroundColor = Colors.white,
    this.visiblePageCount = defaultVisiblePageCount,
    this.cardShape,
    required this.data,
    required this.timeMachineController,
  }) : super(key: key);

  /// The first style of Time Machine.
  factory BaseTimeMachine.observatory({
    TMData? data,
    Size? size,
    Color? backgroundColor,
    ShapeBorder? cardShape,
    int? visiblePages,
    TimeMachineController? timeController,
  }) =>
      BaseTimeMachine(
        data: data ?? TMData.placeholder(),
        size: size!,
        backgroundColor: backgroundColor!,
        cardShape: cardShape,
        visiblePageCount: visiblePages ?? defaultVisiblePageCount,
        timeMachineController:
            timeController ?? const ButtonTimeMachineController(),
      );

  @override
  TimeMachineState createState() => TimeMachineState();
}

class TimeMachineState extends ConsumerState<BaseTimeMachine> {
  double paddingTop = 32;
  double staggeredDistance = 0;
  int visiblePageCount = defaultVisiblePageCount;

  _getVisibleCards(WidgetRef ref) {
    final currentCardIndex = ref.watch(statusProvider).currentIndex;
    List<TMCard> data;
    if (widget.data.cards.isEmpty) {
      data = TMData.placeholder().cards;
    } else {
      if (widget.visiblePageCount != null &&
          widget.data.cards.length > widget.visiblePageCount!) {
        visiblePageCount = widget.visiblePageCount!;
      } else {
        visiblePageCount = widget.data.cards.length > widget.visiblePageCount!
            ? widget.visiblePageCount!
            : widget.data.cards.length;
      }
      data = widget.data.cards
          .skip(currentCardIndex)
          .take(visiblePageCount)
          .toList();
    }
    return data;
  }

  /// Build a stacked list of cards,
  /// showing by default the entire contents of the first page
  /// and the headers of next two pages.
  List<Positioned> _buildCards(WidgetRef ref) {
    List<TMCard> data = _getVisibleCards(ref);

    staggeredDistance = paddingTop / visiblePageCount;

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
  void initState() {
    super.initState();
    ref.read(statusProvider.notifier).updateCount(widget.data.cards.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref, _) {
              return Stack(
                children: _buildCards(ref),
              );
            },
          ),
        ),
        widget.timeMachineController,
      ],
    );
  }
}

abstract class TimeMachineController extends ConsumerWidget {
  const TimeMachineController({Key? key}) : super(key: key);
  onMove(MoveType moveType, WidgetRef ref);

  buildWidget(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildWidget(ref);
  }
}

class ButtonTimeMachineController extends TimeMachineController {
  const ButtonTimeMachineController({Key? key}) : super(key: key);

  _getOnPressed(MoveType moveType, WidgetRef ref) {
    final int? edge = ref.watch(edgeProvider);
    switch (edge) {
      case -1:
        if (moveType == MoveType.back) {
          return;
        }
        return onMove(moveType, ref);
      case 1:
        if (moveType == MoveType.next) {
          return;
        }
        return onMove(moveType, ref);
      case null:
      default:
        return onMove(moveType, ref);
    }
  }

  @override
  buildWidget(WidgetRef ref) {
    return SizedBox(
      height: 72,
      width: 256,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () => _getOnPressed(MoveType.back, ref),
            fillColor: Colors.yellow[100],
            elevation: 0,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: const Text('back'),
          ),
          const SizedBox(
            width: 16,
          ),
          RawMaterialButton(
            onPressed: () => _getOnPressed(MoveType.next, ref),
            fillColor: Colors.yellow[100],
            elevation: 0,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: const Text('next'),
          ),
        ],
      ),
    );
  }

  @override
  onMove(MoveType moveType, WidgetRef ref) {
    switch (moveType) {
      case MoveType.next:
        ref.read(statusProvider.notifier).add(1);
        break;
      case MoveType.back:
        ref.read(statusProvider.notifier).reduce(1);
        break;
      default:
        return;
    }
  }
}
