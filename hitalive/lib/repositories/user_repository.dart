import 'package:hitalive/dto/dto.dart';
import 'package:hitalive/providers/providers.dart';
import 'package:hitalive/ro/ro.dart';

class UserRepository {
  const UserRepository({required this.userProvider});

  final UserProvider userProvider;

  Future<UserRO?> getUserInfo() async {
    try {
      final user = await userProvider.getUserInfo();
      return user != null ? UserRO.fromJson(user) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addVerifyInformation(VerifyInfoDTO body) async {
    return userProvider.addVerifyInformation(body);
  }

  Future<void> updatePushToken(String token) async {
    return userProvider.updatePushToken(token);
  }
}
