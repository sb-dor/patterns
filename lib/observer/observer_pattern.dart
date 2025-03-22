import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

abstract interface class OwnListenable {
  void addSubscriber(VoidCallback subscriber);

  void removeSubscriber(VoidCallback subscriber);
}

mixin class SubscriberNotifier implements OwnListenable {
  final List<VoidCallback> _subscribers = [];

  @override
  void addSubscriber(VoidCallback subscriber) {
    _subscribers.add(subscriber);
  }

  @override
  void removeSubscriber(VoidCallback subscriber) {
    for (int index = 0; index < _subscribers.length; index++) {
      if (_subscribers[index] == subscriber) {
        _subscribers.removeAt(index);
      }
    }
  }

  void notifySubscribers() {
    for (final subscriber in _subscribers) {
      subscriber.call();
    }
  }
}

class OwnListenableBuilder extends StatefulWidget {
  const OwnListenableBuilder({super.key, required this.listenable, required this.builder});

  final OwnListenable listenable;
  final Widget Function(BuildContext context) builder;

  @override
  State<OwnListenableBuilder> createState() => _OwnListenableBuilderState();
}

class _OwnListenableBuilderState extends State<OwnListenableBuilder> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addSubscriber(_listener);
  }

  @override
  void dispose() {
    widget.listenable.removeSubscriber(_listener);
    super.dispose();
  }

  void _listener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
