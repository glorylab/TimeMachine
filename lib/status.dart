import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeMachineStatus {
  final int currentIndex;
  final int count;

  TimeMachineStatus({required this.currentIndex, required this.count});

  factory TimeMachineStatus.init() =>
      TimeMachineStatus(count: 0, currentIndex: 0);

  @override
  String toString() {
    return 'total: $count | current: $currentIndex';
  }
}

class StatusNotifier extends StateNotifier<TimeMachineStatus> {
  StatusNotifier(TimeMachineStatus? init)
      : super(init ?? TimeMachineStatus.init());

  void add(int quantity) {
    if ((state.currentIndex + quantity) < state.count) {
      state = TimeMachineStatus(
          currentIndex: state.currentIndex + quantity, count: state.count);
    }
  }

  void reduce(int quantity) {
    if (state.currentIndex >= quantity) {
      state = TimeMachineStatus(
          currentIndex: state.currentIndex - quantity, count: state.count);
    }
  }

  void updateCount(int count) {
    state = TimeMachineStatus(currentIndex: state.currentIndex, count: count);
  }
}
