class RegisterDTO {
  final String email;
  final String password;

  RegisterDTO({required this.email, required this.password});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  static RegisterDTO fromJson(Map<String, dynamic> json) {
    return RegisterDTO(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}