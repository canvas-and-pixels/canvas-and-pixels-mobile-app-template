import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

class AnalyticsService {
  late Mixpanel _mixpanel;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _mixpanel = await Mixpanel.init(
      'YOUR_MIXPANEL_TOKEN',
      optOutTrackingDefault: true,
      trackAutomaticEvents: true,
      
      // optOut: false,
      // track: true,
    );
    _isInitialized = true;
  }

  Future<void> identify(String userId) async {
    if (!_isInitialized) await initialize();
    _mixpanel.identify(userId);
  }

  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isInitialized) await initialize();
    _mixpanel.track(name, properties: parameters);
  }

  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (!_isInitialized) await initialize();
    _mixpanel.getPeople().set(name, value);
  }

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

  Future<void> incrementUserProperty(String property, [num value = 1]) async {
    if (!_isInitialized) await initialize();
    // _mixpanel.getPeople().increment(property, value);
  }

  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    if (!_isInitialized) await initialize();
    // _mixpanel.getPeople().setMap(properties);
  }

  Future<void> reset() async {
    if (!_isInitialized) await initialize();
    _mixpanel.reset();
  }
} 