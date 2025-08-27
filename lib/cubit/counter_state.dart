class CounterState {
  final int counter;

  CounterState(this.counter);
}

class IncrementCounter extends CounterState {
  IncrementCounter(super.counter);
}

class DecrementCounter extends CounterState {
  DecrementCounter(super.counter);

}