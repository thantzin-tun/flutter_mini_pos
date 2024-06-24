import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterOperationsSuccess(0)) {
    on<CounterIncreaseEvent>(increase);
    on<CounterDecreaseEvent>(decrease);
  }

  FutureOr<void> increase(
      CounterIncreaseEvent event, Emitter<CounterState> emit) {
    logger("Event: ", "Counter Increase Event");
    if (state is CounterOperationsSuccess) {
      final currentState = state as CounterOperationsSuccess;
      final newCounter = currentState.counter + event.value;
      logger("Event: ", "Counter Increase Event");
      emit(CounterOperationsSuccess(newCounter));
    }
  }

  FutureOr<void> decrease(
      CounterDecreaseEvent event, Emitter<CounterState> emit) {
    logger("Event: ", "Counter Decrease Event");
    emit(CounterOperationsSuccess(event.value));
  }
}
