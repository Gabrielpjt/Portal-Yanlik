class AppConfig {
  // Singleton pattern
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  // Environment
  String get environment => const String.fromEnvironment(
        'ENV',
        defaultValue: 'development',
      );

  bool get isDevelopment => environment == 'development';
  bool get isProduction => environment == 'production';
  bool get isStaging => environment == 'staging';

  // API Configuration
  String get baseUrl {
    switch (environment) {
      case 'production':
        return 'http://217.217.254.139:4002';
      case 'staging':
        return 'http://217.217.254.139:4002';
      default:
        return 'http://217.217.254.139:4002';
    }
  }

  int get apiTimeout => 30000; // 30 seconds

  // App Information
  String get appName => 'Portal Layanan Publik';
  String get appVersion => '1.0.0';
}
