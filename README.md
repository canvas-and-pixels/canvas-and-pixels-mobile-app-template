# Flutter Mobile App Template

A comprehensive Flutter template for building efficient MVP SaaS mobile applications.

## Features

### Core Features
- 🎨 Modern UI components with customizable themes
- 📱 Responsive design using `flutter_screenutil`
- 🔄 State management with `flutter_riverpod`
- 🌐 Network handling with `dio`
- 🔒 Secure storage with `flutter_secure_storage`
- 📦 Local storage with `shared_preferences`
- 🔄 JSON serialization with `json_serializable`
- 🎯 Type-safe models with `freezed`

### Analytics & Monitoring
- 📊 Flexible analytics interface supporting multiple providers
  - Mixpanel (default)
  - Easy to add more providers
- 📱 Device information tracking
- 📡 Network connectivity monitoring
- 🔔 Local notifications support

### Subscription Management
- 💳 RevenueCat integration for in-app purchases
- 🔄 Subscription management and tracking
- 💰 Secure payment processing
- 📊 Subscription analytics
- 🔄 Cross-platform subscription sync

### CI/CD & Deployment
- 🔄 GitHub Actions for automated CI/CD
- 🚀 Fastlane for automated deployment
- 📦 Automated version management
- 🔍 Automated testing
- 📱 Automated builds for Android and iOS

### UI Components
- 🎨 Custom scaffold with safe area
- 💬 Custom dialogs and modals
- 📝 Custom text fields
- 🔘 Custom buttons with loading states
- 🖼️ Image caching with `cached_network_image`
- ✨ Loading animations with `shimmer`
- 🎨 SVG support with `flutter_svg`

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Set up Analytics:
   - For Mixpanel (default):
     - Sign up for a Mixpanel account at https://mixpanel.com
     - Get your project token
     - Replace 'YOUR_MIXPANEL_TOKEN' in `lib/services/analytics/mixpanel_analytics.dart`

4. Set up RevenueCat:
   - Sign up for a RevenueCat account at https://www.revenuecat.com
   - Create your app and get your public SDK key
   - Replace 'YOUR_REVENUECAT_PUBLIC_SDK_KEY' in `lib/services/subscription/revenuecat_service.dart`
   - Configure your products in the RevenueCat dashboard

5. Set up CI/CD:
   - For GitHub Actions:
     - Add your secrets in GitHub repository settings:
       - `PLAY_STORE_CONFIG_JSON`: Your Play Store service account JSON
   - For Fastlane:
     - Install Ruby and Bundler
     - Run `bundle install` in the `fastlane` directory
     - Configure your Play Store credentials in `fastlane/play-store-credentials.json`

6. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/           # Core functionality and configurations
├── features/       # Feature-specific code
├── shared/         # Shared widgets and utilities
├── services/       # Service implementations
│   ├── analytics/  # Analytics implementations
│   │   ├── analytics_interface.dart
│   │   ├── analytics_provider.dart
│   │   └── mixpanel_analytics.dart
│   └── subscription/  # Subscription management
│       └── revenuecat_service.dart
└── main.dart       # App entry point
```

## Usage

### Analytics
The template provides a flexible analytics interface that can be implemented by different providers. By default, it uses Mixpanel, but you can easily switch to other providers.

```dart
final analytics = ref.read(analyticsServiceProvider);

// Initialize analytics
await analytics.initialize();

// Identify user
await analytics.identify('user123');

// Track event
await analytics.logEvent(
  name: 'user_action',
  parameters: {'action': 'button_click'},
);

// Set user property
await analytics.setUserProperty(
  name: 'subscription_status',
  value: 'premium',
);

// Track screen view
await analytics.logScreenView(
  screenName: 'Home Screen',
  screenClass: 'HomeScreen',
);

// Track purchase
await analytics.logPurchase(
  currency: 'USD',
  value: 9.99,
  itemId: 'sub_123',
  itemName: 'Premium Subscription',
);

// Increment user property
await analytics.incrementUserProperty('total_purchases');

// Set multiple user properties
await analytics.setUserProperties({
  'name': 'John Doe',
  'email': 'john@example.com',
  'plan': 'premium',
});
```

### Subscriptions with RevenueCat
```dart
final revenueCat = ref.read(revenueCatServiceProvider);

// Initialize RevenueCat
await revenueCat.initialize();

// Identify user
await revenueCat.identifyUser('user123');

// Get available offerings
final offerings = await revenueCat.getOfferings();

// Purchase a package
final customerInfo = await revenueCat.purchasePackage(offerings[0].availablePackages[0]);

// Check subscription status
final isSubscribed = await revenueCat.isSubscribed();

// Restore purchases
final restoredInfo = await revenueCat.restorePurchases();

// Get customer info
final customerInfo = await revenueCat.getCustomerInfo();
```

### CI/CD Commands

#### GitHub Actions
The following workflows are available:
- `build`: Builds and tests the app
- `deploy-android`: Deploys to Play Store (on main branch)

#### Fastlane
```bash
# Deploy to Play Store
bundle exec fastlane deploy_android

# Run tests
bundle exec fastlane test

# Build APK
bundle exec fastlane build_apk
```

### UI Components
```dart
CustomScaffold(
  appBar: AppBar(title: Text('My App')),
  body: Center(child: Text('Hello World')),
);

CustomButton(
  text: 'Click Me',
  onPressed: () => print('Button clicked'),
);

CustomTextField(
  label: 'Username',
  controller: _usernameController,
);
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
