// simple explanation of observer pattern in order to figure it out how it works
// but remember that change notifier was done better, with performance and working with memory
// you can create your own notifier but remember that do not use your own notifiers for projects!

import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

abstract interface class OwnListenable {
  void addSubscriber(VoidCallback subscriber);

  void removeSubscriber(VoidCallback subscriber);
}

// mixin class so we can create object from this mixin
mixin class SubscriberNotifier implements OwnListenable {
  //
  /// a list of callbacks that should be added as subscriber
  /// when someone calls [notifySubscribers] all subscribers (callbacks) will be called
  final List<VoidCallback> _subscribers = [];

  // adding subscriber (callback) inside a list of subscribers
  @override
  void addSubscriber(VoidCallback subscriber) {
    _subscribers.add(subscriber);
  }

  /// removing specific subscriber (callback) from the list in order to not call him
  /// when [notifySubscribers] calls
  @override
  void removeSubscriber(VoidCallback subscriber) {
    for (int index = 0; index < _subscribers.length; index++) {
      if (_subscribers[index] == subscriber) {
        _subscribers.removeAt(index);
      }
    }
  }

  // calling each subscriber (callback)
  void notifySubscribers() {
    for (final subscriber in _subscribers) {
      subscriber.call();
    }
  }

  // clearing callbacks
  void dispose() {
    _subscribers.clear();
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
