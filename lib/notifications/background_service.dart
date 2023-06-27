import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'notification_config.dart';
import 'push_notifications.dart';

/// Callback dispatcher for background services.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case 'push-notifications':
        await fetchNotifications();
        break;
    }
    return Future.value(true);
  });
}

/// Initializes background services.
void initBackgroundServices() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: pushNotificationsServiceDebugMode,
  );

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
