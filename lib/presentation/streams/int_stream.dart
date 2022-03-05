import 'dart:async';

class IntStream {
  final StreamController<int?> _controller = StreamController<int?>.broadcast();
  StreamSink<int?> get sink => _controller.sink;
  Stream<int?> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
