import 'dart:convert';

import 'http.dart';
import 'notification.dart';
import 'notification_config.dart';
import 'notification_service.dart';
import 'storage.dart';

/// Fetches notifications from the server and displays new ones.
Future<void> fetchNotifications() async {
  List<Notification> notifications = await _getNotifications();
  notifications.sort((a, b) => a.id.compareTo(b.id));

  if (notifications.isNotEmpty) {
    String? lastShownNotificationIdStr = await _getLastShownNotificationId();

    // First time running the app.
    if (lastShownNotificationIdStr == null) {
      print('First time running the app. Displaying no notifications.');
      return await _setLastShownNotificationId(notifications);
    }

    // Display notifications that haven't been shown yet.
    int lastShownNotificationId = int.parse(lastShownNotificationIdStr);
    await _showNotifications(notifications, lastShownNotificationId);

    // Update the last shown notification id.
    await _setLastShownNotificationId(notifications);
  }
}

/// Displays a notification.
Future<void> _showNotification(
    NotificationService notificationService, Notification notification) async {
  await notificationService.showLocalNotification(
    id: notification.id,
    title: notification.title,
    body: notification.body,
    payload: notification.payload,
  );
}

/// Displays notifications that haven't been shown yet.
Future<void> _showNotifications(
    List<Notification> notifications, int lastShownNotificationId) async {
  NotificationService notificationService =
      await _initializeNotificationService();

  for (final notification in notifications) {
    if (notification.id > lastShownNotificationId || true) {
      print('Displaying notification: ${notification.id}');
      await _showNotification(notificationService, notification);
    }
  }
}

/// Sets the last shown notification id in storage.
Future<void> _setLastShownNotificationId(
    List<Notification> notifications) async {
  int lastShownNotificationId = notifications.last.id;
  await Storage.set(
    'lastShownNotificationId',
    lastShownNotificationId.toString(),
  );
}

/// Gets the last shown notification id from storage.
Future<String?> _getLastShownNotificationId() async {
  return await Storage.get('lastShownNotificationId', throwOnFail: false);
}

/// Initializes a new instance of [NotificationService].
Future<NotificationService> _initializeNotificationService() async {
  NotificationService notificationService = NotificationService();
  await notificationService.initializePlatformNotifications();
  return notificationService;
}

/// Fetches notifications from the server.
Future<List<Notification>> _getNotifications() async {
  final response = await Http.get(pushNotificationsRestApi, {});

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
