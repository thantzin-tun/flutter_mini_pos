part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncreaseEvent extends CounterEvent {
  final int value;
  const CounterIncreaseEvent(this.value);
}

class CounterDecreaseEvent extends CounterEvent {
  final int value;
  const CounterDecreaseEvent(this.value);
}
