import 'dart:async';

// Base class for events, represents a generic event with a userName
sealed class PubSubEvents {
  PubSubEvents(this.userName);

  final String userName;
}

// Specific event for regular users
final class UserName extends PubSubEvents {
  UserName(super.userName);
}

// Specific event for admins
final class AdminName extends PubSubEvents {
  AdminName(super.userName);
}

// Generic event bus to handle events of type T (which must extend PubSubEvents)
class EventBus<T extends PubSubEvents> {
  // Stream controller that allows multiple listeners
  final _controller = StreamController<T>.broadcast();

  // Publishes (sends) an event to all subscribers
  void publish(T event) {
    _controller.add(event);
  }

  // Returns the stream so listeners can receive events
  Stream<T> get stream => _controller.stream;

  // Allows filtering events by type, so subscribers can listen only to what they need
  Stream<T> subscribe<T>() {
    return _controller.stream.where((element) => element is T).cast<T>();
  }

  // Closes the stream when no longer needed (to free up resources)
  void close() {
    _controller.close();
  }
}
