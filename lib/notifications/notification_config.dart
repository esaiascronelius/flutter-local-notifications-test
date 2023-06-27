// Push-notifications configuration.
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const bool pushNotificationsServiceDebugMode = false; // Enable debug mode.
const String pushNotificationsRestApi = 'https://pastebin.com/raw/f3A3RMKw';
const int pushNotificationsRequestTimeout = 20; // In seconds.
const int pushNotificationsPollingInterval = 15; // In minutes. Min 15 minutes.

const String pushNotificationsAndroidDefaultIcon =
    '@mipmap/ic_launcher'; // Android only.
const String pushNotificationsAndroidChannelId = 'channel_id'; // Android only.
const String pushNotificationsAndroidChannelName =
    'channel_name'; // Android only.
const String pushNotificationsAndroidChannelGroup =
    'com.example.app'; // Android only.
const String pushNotificationsAndroidChannelDescription =
    'channel_description'; // Android only.
const Importance pushNotificationsAndroidImportance =
    Importance.defaultImportance; // Android only.
const Priority pushNotificationsAndroidPriority =
    Priority.defaultPriority; // Android only.
const bool pushNotificationsAndroidPlaySound = true; // Android only.
const String pushNotificationsAndroidTicker = 'ticker'; // Android only.

const bool pushNotificationsIosRequestAlertPermission = false; // iOS only.
const bool pushNotificationsIosRequestBadgePermission = false; // iOS only.
const bool pushNotificationsIosRequestSoundPermission = false; // iOS only.
const bool pushNotificationsIosPresentAlert = true; // iOS only.
const String? pushNotificationsIosSound = null; // iOS only.
const String pushNotificationsIosThreadIdentifier = 'thread1'; // iOS only.