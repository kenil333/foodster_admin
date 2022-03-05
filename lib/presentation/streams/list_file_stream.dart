import 'dart:async';

import 'dart:io';

class ListFileStream {
  final StreamController<List<File>> _controller =
      StreamController<List<File>>.broadcast();
  StreamSink<List<File>> get sink => _controller.sink;
  Stream<List<File>> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
