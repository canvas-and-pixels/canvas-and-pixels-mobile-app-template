import 'dart:io';

import 'package:canvas_and_pixels_mobile_app_template/services/notifications/notifications_service_interface.dart';
import 'package:canvas_and_pixels_mobile_app_template/shared/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationsService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> cancelAllNotifications() async {
    
    throw UnimplementedError();
  }

  @override
  Future<void> cancelNotification(int id) {
    // TODO: implement cancelNotification
    throw UnimplementedError();
  }

  @override
  Future<String?> getNotificationToken() {
    // TODO: implement getNotificationToken
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  void onNotificationTap(Function(String? payload) onTap) {
    // TODO: implement onNotificationTap
  }

  @override
  Future<void> requestPermission() async {
    await _requestPermission();
  }

  @override
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime scheduledTime}) {
    // TODO: implement scheduleNotification
    throw UnimplementedError();
  }

  @override
  Future<void> showLocalNotification(
      {required int id,
      required String title,
      required String body,
      String? payload}) {
    // TODO: implement showLocalNotification
    throw UnimplementedError();
  }

  @override
  Future<void> subscribeToTopic(String topic) {
    // TODO: implement subscribeToTopic
    throw UnimplementedError();
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) {
    // TODO: implement unsubscribeFromTopic
    throw UnimplementedError();
  }

  Future<void> _requestPermission() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  @override
  Future<String?> getPushToken() async {
    final token = await _firebaseMessaging.getToken();
    AppLogger.info('FCM token =>$token');
    return token;
  }

  /// Shows a local notification when a push message arrives in the foreground.
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'push_channel',
      'Push Notifications',
      channelDescription: 'Notifications for push messages',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  /// Initializes Firebase Cloud Messaging (FCM).
  Future<void> _initializeFCM() async {
    // Handle notifications when the app is opened from a terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        AppLogger.success(
            'Opened from Terminated: ${message.notification?.title}');
      }
    });

    // Handle when the app is in the background and tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppLogger.success('Notification Opened: ${message.notification?.title}');
    });
  }
}
