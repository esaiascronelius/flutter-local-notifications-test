import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_test/push_notifications.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  print('Native called background task');
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case 'push-notifications':
        await fetchNotifications();
        break;
      default:
        print('Unknown task $taskName');
    }
    return Future.value(true);
  });
}

void initBackgroundServices() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  Workmanager().registerPeriodicTask(
    'push-notifications',
    'push-notifications',
    frequency: const Duration(seconds: 5),
    initialDelay: const Duration(seconds: 5),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}
