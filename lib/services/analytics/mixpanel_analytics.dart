import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'analytics_interface.dart';

class MixpanelAnalytics implements AnalyticsInterface {
  late Mixpanel _mixpanel;
  bool _isInitialized = false;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    _mixpanel = await Mixpanel.init(
      'YOUR_MIXPANEL_TOKEN',
      trackAutomaticEvents: true,
    );
    _isInitialized = true;
  }

  @override
  Future<void> identify(String userId) async {
    if (!_isInitialized) await initialize();
    _mixpanel.identify(userId);
  }

  @override
  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isInitialized) await initialize();
    _mixpanel.track(name, properties: parameters);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (!_isInitialized) await initialize();
    _mixpanel.getPeople().set(name, value);
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_isInitialized) await initialize();
    _mixpanel.track(
      'Screen View',
      properties: {
        'screen_name': screenName,
        if (screenClass != null) 'screen_class': screenClass,
      },
    );
  }

  @override
  Future<void> logPurchase({
    required String currency,
    required double value,
    required String itemId,
    required String itemName,
  }) async {
    if (!_isInitialized) await initialize();
    _mixpanel.track(
      'Purchase',
      properties: {
        'currency': currency,
        'value': value,
        'item_id': itemId,
        'item_name': itemName,
      },
    );
  }

  @override
  Future<void> incrementUserProperty(String property, [num value = 1]) async {
    if (!_isInitialized) await initialize();
    _mixpanel.getPeople().increment(property, value.toDouble());
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    if (!_isInitialized) await initialize();
    // _mixpanel.getPeople().set(jsonE);
  }

  @override
  Future<void> reset() async {
    if (!_isInitialized) await initialize();
    _mixpanel.reset();
  }
}
