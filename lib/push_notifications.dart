import 'dart:convert';

import 'package:flutter_local_notifications_test/http.dart';
import 'package:flutter_local_notifications_test/notification.dart';
import 'package:flutter_local_notifications_test/notification_service.dart';

Future<void> fetchNotifications() async {
  List<Notification> notifications = await _getNotifications();

  if (notifications.isNotEmpty) {
    NotificationService notificationService = NotificationService();
    await notificationService.initializePlatformNotifications();

    for (final notification in notifications) {
      await notificationService.showLocalNotification(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
      );
    }
  }
}

/// Fetches notifications from the server.
Future<List<Notification>> _getNotifications() async {
  final response = await Http.get('https://pastebin.com/raw/f3A3RMKw', {});

  if (response.statusCode != 200) {
    throw Exception('Failed to load notifications');
  }

  final notifications = <Notification>[];
  final json = jsonDecode(response.body);
  for (final notificationJson in json) {
    notifications.add(Notification.fromJson(notificationJson));
  }

  return notifications;
}
