class LoginDTO {
  final String email;
  final String password;

  LoginDTO({required this.email, required this.password});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['username'] = email;
    data['password'] = password;
    return data;
  }

  static LoginDTO fromJson(Map<String, dynamic> json) {
    return LoginDTO(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
