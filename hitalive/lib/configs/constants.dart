import 'api_url.dart';

class Constants {
  /// Key lưu trong secure storage
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  /// Key lưu trong shared_preferences
  static const String firstAppInstall = 'first_app_install';
  static const String accessTokenInfo = 'access_token_info';

  /// Các API URL không cần kiểm tra refresh token
  static const List<String> excludeApiURL = [
    ApiUrl.login,
    ApiUrl.register
  ];
}