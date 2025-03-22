import 'package:flutter/material.dart';
import 'package:observer_and_pubsub_patterns/pub_sub_pattern/simple_simple_pattern.dart';
import 'observer/app_observer_pattern.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final eventBus = EventBus();

  eventBus.subscribe<UserName>().listen((user) {
    print("User is: ${user.userName}");
  });

  eventBus.subscribe<AdminName>().listen((admin) {
    print("Admin is: ${admin.userName}");
  });

  eventBus.stream.listen((allUsers) {
    switch (allUsers) {
      case final UserName user:
        print("all users is user: ${user.userName}");
        break;
      case final AdminName admin:
        print("all users is admin: ${admin.userName}");
        break;
    }
  });

  await Future.delayed(const Duration(seconds: 3));

  eventBus.publish(UserName("Bob"));

  await Future.delayed(const Duration(seconds: 3));

  eventBus.publish(AdminName("John"));

  await Future.delayed(const Duration(seconds: 3));

  eventBus.publish(UserName("Joel"));

  eventBus.close();


  runApp(AppObserverPattern());
}
