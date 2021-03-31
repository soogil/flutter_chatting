import 'dart:async';

class StreamManager {
  bool _isDisposed = false;

  final Map<String, StreamSubscription<dynamic>> _streamMap = Map();

  bool get isDisposed => _isDisposed;

  StreamSubscription<T> add<T>(String tag, StreamSubscription<T> subscription) {
    if (isDisposed) {
      throw ("This manager was disposed, try to use new instance instead");
    }
    _streamMap[tag] = subscription;
    return subscription;
  }

  void remove(String tag) {
    _streamMap[tag]?.cancel();
    _streamMap.remove(tag);
  }

  void removeAll() {
    _streamMap.forEach((key, value) {
      value.cancel();
    });
    _streamMap.clear();
  }

  void dispose() {
    removeAll();
    _isDisposed = true;
  }

  bool contains(String tag) => _streamMap.containsKey(tag);
}

abstract class StreamProvider {
  factory StreamProvider._() => null;

  final StreamManager _streamManager = StreamManager();

  void addStream(String tag, StreamSubscription stream, [bool reset = true]) {
    if (reset) removeStream(tag);
    _streamManager.add(tag, stream);
  }

  void removeStream(String tag) {
    _streamManager.remove(tag);
  }

  bool contains(String tag) => _streamManager.contains(tag);

  void removeAllStream() => _streamManager.removeAll();

  void disposeStream() => _streamManager.dispose();
}