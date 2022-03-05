import 'dart:async';

class StringStream {
  final StreamController<String?> _controller =
      StreamController<String?>.broadcast();
  StreamSink<String?> get sink => _controller.sink;
  Stream<String?> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
