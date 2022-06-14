import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/dto/dto.dart';
import 'package:hitalive/http/http.dart';

class UserProvider {
  UserProvider(this.httpClient);

  final HttpClient httpClient;

  Future<dynamic> getUserInfo() async {
    return await httpClient.get(ApiUrl.userInfo);
  }

  Future<dynamic> addVerifyInformation(VerifyInfoDTO body) async {
    final data = await body.toFormData();
    return await httpClient.putFormData(ApiUrl.addVerifyInformation, data);
  }

  Future<dynamic> updatePushToken(String token) async {
    return await httpClient.put(ApiUrl.updatePushToken, body: {'token': token});
  }
}
