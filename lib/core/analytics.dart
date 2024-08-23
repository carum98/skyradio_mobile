import 'package:skyanalytics/skyanalytics_flutter.dart';

class Analytics {
  final _skAnalytics = const SkyAnalytics(
    sourceKey: String.fromEnvironment('analyticsKey'),
    host: String.fromEnvironment('analyticsHost'),
  );

  SkyAnalyticsNavigatorObserver skyAnalyticsObserver() =>
      SkyAnalyticsNavigatorObserver(skyAnalytics: _skAnalytics);

  Future<void> logEvent({required String name}) async {
    await _skAnalytics.event(name: name);
  }
}
