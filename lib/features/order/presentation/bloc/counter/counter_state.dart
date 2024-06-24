part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

final class CounterOperationsSuccess extends CounterState {
  final int counter;
  const CounterOperationsSuccess(this.counter);
  @override
  List<Object> get props => [counter];
}
