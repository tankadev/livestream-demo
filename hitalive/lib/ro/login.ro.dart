class LoginRO {
  final String accessToken;
  final String refreshToken;

  LoginRO({required this.accessToken, required this.refreshToken});

  static LoginRO fromJson(Map<String, dynamic> json) {
    return LoginRO(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}
