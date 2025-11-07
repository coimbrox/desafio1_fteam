import 'package:desafio1_fteam/constants/urls.constants.dart';

class AppConfig {
  final String appName;
  final String flavor;
  final bool showDebugBanner;
  final String apiBaseUrl;

  const AppConfig({
    required this.appName,
    required this.flavor,
    required this.showDebugBanner,
    required this.apiBaseUrl,
  });

  static const AppConfig development = AppConfig(
    appName: 'Desafio Rick and Morty Fteam',
    flavor: 'development',
    showDebugBanner: true,
    apiBaseUrl: ApiConstants.api,
  );

  static const AppConfig production = AppConfig(
    appName: 'Desafio Rick and Morty Fteam',
    flavor: 'production',
    showDebugBanner: false,
    apiBaseUrl: ApiConstants.api,
  );
}

const AppConfig appConfig = AppConfig.development;
