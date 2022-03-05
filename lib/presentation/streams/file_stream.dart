import 'dart:async';

import 'dart:io';

class FileStream {
  final StreamController<File?> _controller =
      StreamController<File?>.broadcast();
  StreamSink<File?> get sink => _controller.sink;
  Stream<File?> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
