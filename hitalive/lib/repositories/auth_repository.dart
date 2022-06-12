import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/providers/providers.dart';
import 'package:hitalive/repositories/storage_repository.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/dto/dto.dart';
import 'package:hitalive/ro/ro.dart';
import 'package:hitalive/utilities/utilities.dart';

class AuthRepository {
  AuthRepository({required this.authProvider, required this.storage});

  final AuthProvider authProvider;
  final StorageRepository storage;
  final _controller = StreamController<EAuthStatus>();

  Stream<EAuthStatus> get status async* {
    final prefs = await SharedPreferences.getInstance();
    final bool? isFirstAppInstall = prefs.getBool(Constants.firstAppInstall);
    if (isFirstAppInstall ?? true) {
      await storage.deleteAllSecure();
      prefs.setBool(Constants.firstAppInstall, false);
    }
    final String? _accessToken =
        await storage.readSecure(key: Constants.accessToken) ?? '';
    final String? _refreshToken =
        await storage.readSecure(key: Constants.refreshToken) ?? '';
    if (_accessToken!.isNotEmpty && _refreshToken!.isNotEmpty) {
      yield EAuthStatus.authenticated;
    } else {
      yield EAuthStatus.unknown;
    }
    yield* _controller.stream;
  }

  Future<void> logIn(LoginDTO loginDTO) async {
    try {
      final data = await authProvider.login(loginDTO);
      final loginRO = LoginRO.fromJson(data);
      await PrefsUtilities.saveAccessTokenInfo(
          accessToken: loginRO.accessToken);
      await storage.saveAuthentication(
        accessToken: loginRO.accessToken,
        refreshToken: loginRO.refreshToken,
      );
      _controller.add(EAuthStatus.authenticated);
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> register(RegisterDTO registerDTO) async {
    return await authProvider.register(registerDTO);
  }

  Future<void> logOut() async {
    await storage.deleteAllSecure();
    // await PrefsUtilities.removeAllPrefs();
    _controller.add(EAuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
