import 'dart:async';

class ListStringStream {
  final StreamController<List<String>> _controller =
      StreamController<List<String>>();
  StreamSink<List<String>> get sink => _controller.sink;
  Stream<List<String>> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
