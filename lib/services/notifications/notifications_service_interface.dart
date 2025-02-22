abstract class INotificationService {
  /// Initializes the notification service (e.g., Firebase, OneSignal setup)
  Future<void> initialize();

  /// Requests permission for push notifications
  Future<void> requestPermission();

  /// Subscribes the user to a specific topic (e.g., "news_updates")
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes the user from a topic
  Future<void> unsubscribeFromTopic(String topic);

  /// Sends a local notification
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });

  /// Handles notification taps (deep linking)
  void onNotificationTap(Function(String? payload) onTap);

  /// Retrieves the notification token (for push notifications)
  Future<String?> getNotificationToken();

  /// Schedules a notification at a later time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  });

  /// Cancels a scheduled or active notification
  Future<void> cancelNotification(int id);

  /// Cancels all notifications
  Future<void> cancelAllNotifications();

  Future<String?> getPushToken();
}
