import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/dto/dto.dart';
import 'package:hitalive/http/http.dart';

class AuthProvider {
  AuthProvider(this.httpClient);

  final HttpClient httpClient;

  Future<dynamic> login(LoginDTO loginDTO) async {
    return await httpClient.post(ApiUrl.login, body: loginDTO.toJson());
  }

  Future<dynamic> register(RegisterDTO registerDTO) async {
    return await httpClient.post(ApiUrl.register, body: registerDTO.toJson());
  }
}
