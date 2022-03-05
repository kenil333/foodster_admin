import 'dart:async';

class BoolStream {
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  StreamSink<bool> get sink => _controller.sink;
  Stream<bool> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
