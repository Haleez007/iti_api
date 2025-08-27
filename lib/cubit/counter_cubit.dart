import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(0));

  void increment() {
    emit(CounterState(state.counter + 1));
  }

  void decrement() {
    if (state.counter > 0) {
      emit(CounterState(state.counter - 1));
    } else {
      emit(CounterState(0)); 
    }
  }
}