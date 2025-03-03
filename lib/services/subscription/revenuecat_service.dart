import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final revenueCatServiceProvider = Provider<RevenueCatService>((ref) {
  return RevenueCatService();
});

class RevenueCatService {
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    await Purchases.setup('YOUR_REVENUECAT_PUBLIC_SDK_KEY');
    _isInitialized = true;
  }

  // Future<CustomerInfo> identifyUser(String userId) async {
  //   if (!_isInitialized) await initialize();
  //   // return await Purchases.logIn(userId);
  // }

  Future<List<Offering>> getOfferings() async {
    if (!_isInitialized) await initialize();
    final offerings = await Purchases.getOfferings();
    return offerings.all.values.toList();
  }

  Future<CustomerInfo> purchasePackage(Package package) async {
    if (!_isInitialized) await initialize();
    return await Purchases.purchasePackage(package);
  }

  Future<CustomerInfo> restorePurchases() async {
    if (!_isInitialized) await initialize();
    return await Purchases.restorePurchases();
  }

  Future<CustomerInfo> getCustomerInfo() async {
    if (!_isInitialized) await initialize();
    return await Purchases.getCustomerInfo();
  }

  Future<bool> isSubscribed() async {
    if (!_isInitialized) await initialize();
    final customerInfo = await getCustomerInfo();
    return customerInfo.entitlements.active.isNotEmpty;
  }

  Future<void> logOut() async {
    if (!_isInitialized) await initialize();
    await Purchases.logOut();
  }
} 