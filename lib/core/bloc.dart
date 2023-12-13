import 'dart:async';

abstract class SkBloc<State, Event> {
  SkBloc(State initialState) {
    _controller = StreamController<State>.broadcast();
    _state = initialState;

    _controller.stream.listen((value) => _state = value);
  }

  late final StreamController<State> _controller;
  late State _state;

  void onEvent(Event event);

  Stream<State> get stream => _controller.stream;
  State get state => _state;

  void emit(State state) {
    _controller.add(state);
  }

  void emitError(Object error) {
    _controller.addError(error);
  }

  void dispose() {
    _controller.close();
  }
}
