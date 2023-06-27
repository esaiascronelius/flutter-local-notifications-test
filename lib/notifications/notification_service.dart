import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'notification_config.dart';

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  /// Initializes the notification service.
  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(pushNotificationsAndroidDefaultIcon);

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: pushNotificationsIosRequestAlertPermission,
      requestBadgePermission: pushNotificationsIosRequestBadgePermission,
      requestSoundPermission: pushNotificationsIosRequestSoundPermission,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(initializationSettings);
  }

  /// Gets the notification platform details.
  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      pushNotificationsAndroidChannelId,
      pushNotificationsAndroidChannelName,
      groupKey: pushNotificationsAndroidChannelGroup,
      channelDescription: pushNotificationsAndroidChannelDescription,
      importance: pushNotificationsAndroidImportance,
      priority: pushNotificationsAndroidPriority,
      playSound: pushNotificationsAndroidPlaySound,
      ticker: pushNotificationsAndroidTicker,
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: pushNotificationsIosPresentAlert,
      sound: pushNotificationsIosSound,
      threadIdentifier: pushNotificationsIosThreadIdentifier,
    );

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      behaviorSubject.add(details!.notificationResponse!.payload!);
    }

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );

    return platformChannelSpecifics;
  }

  /// Shows a local notification.
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
