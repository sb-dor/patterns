import 'package:flutter/material.dart';
import 'observer_pattern.dart';

final class TextFieldValidatorController with SubscriberNotifier {
  TextFieldValidatorController(this._textEditingController) {
    _textEditingController.addListener(_listener);
  }

  final TextEditingController _textEditingController;
  String? error;

  bool get isValidate {
    _listener();
    return error == null;
  }

  void _listener() {
    if (_textEditingController.text.trim().isEmpty) {
      error = "Field cannot be empty";
    } else {
      error = null;
    }
    notifySubscribers();
  }

  void dispose() {
    _textEditingController.removeListener(_listener);
  }
}
