import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:observer_and_pubsub_patterns/observer/text_field_validator_controller.dart';
import 'observer_pattern.dart';

final class CounterNotifierProvider with SubscriberNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifySubscribers();
  }
}

class AppObserverPattern extends StatelessWidget {
  const AppObserverPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _HomeWidget(), debugShowCheckedModeBanner: !kReleaseMode);
  }
}

class _HomeWidget extends StatefulWidget {
  const _HomeWidget({super.key});

  @override
  State<_HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<_HomeWidget> {
  late final TextFieldValidatorController _textFieldValidatorController;
  final _counterNotifierProvider = CounterNotifierProvider();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textFieldValidatorController = TextFieldValidatorController(_textEditingController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Observer pattern")),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OwnListenableBuilder(
              listenable: _counterNotifierProvider,
              builder: (context) {
                return TextButton(
                  onPressed: () {
                    _counterNotifierProvider.increment();
                  },
                  child: Text("${_counterNotifierProvider.counter}"),
                );
              },
            ),
            OwnListenableBuilder(
              listenable: _textFieldValidatorController,
              builder: (context) {
                return Column(
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(errorText: _textFieldValidatorController.error),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_textFieldValidatorController.isValidate) {
                          print("IT'S VALIDATED");
                        }
                      },
                      child: Text("${_counterNotifierProvider.counter}"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
