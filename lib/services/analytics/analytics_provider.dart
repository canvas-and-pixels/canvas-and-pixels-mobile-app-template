import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'analytics_interface.dart';
import 'mixpanel_analytics.dart';

// Provider for the analytics implementation
final analyticsImplementationProvider = Provider<AnalyticsInterface>((ref) {
  // You can easily switch between different analytics implementations here
  return MixpanelAnalytics();
});

// Provider for the analytics service
final analyticsServiceProvider = Provider<AnalyticsInterface>((ref) {
  return ref.watch(analyticsImplementationProvider);
}); 