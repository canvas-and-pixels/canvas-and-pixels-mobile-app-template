abstract class AnalyticsInterface {
  Future<void> initialize();
  Future<void> identify(String userId);
  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  });
  Future<void> setUserProperty({
    required String name,
    required String value,
  });
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  });
  Future<void> logPurchase({
    required String currency,
    required double value,
    required String itemId,
    required String itemName,
  });
  Future<void> incrementUserProperty(String property, [num value = 1]);
  Future<void> setUserProperties(Map<String, dynamic> properties);
  Future<void> reset();
} 