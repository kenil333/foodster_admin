import 'dart:async';

import './../../domain/all.dart';

class ListTagStream {
  final StreamController<List<TagModel>> _controller =
      StreamController<List<TagModel>>();
  StreamSink<List<TagModel>> get sink => _controller.sink;
  Stream<List<TagModel>> get stream => _controller.stream;

  dispose() => _controller.close();
}
