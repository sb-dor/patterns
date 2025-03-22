import 'dart:async';

sealed class PubSubEvents {
  PubSubEvents(this.userName);

  final String userName;
}

final class UserName extends PubSubEvents {
  UserName(super.userName);
}

final class AdminName extends PubSubEvents {
  AdminName(super.userName);
}

class EventBus<T extends PubSubEvents> {
  final _controller = StreamController<T>.broadcast();

  void publish(T event) {
    _controller.add(event);
  }

  Stream<T> get stream => _controller.stream;

  Stream<T> subscribe<T>() {
    return _controller.stream.where((element) => element is T).cast<T>();
  }

  void close() {
    _controller.close();
  }
}
