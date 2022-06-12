import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/ro/ro.dart';

class PrefsUtilities {
  static removeAllPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // --------- User Information From Access Token ---------------

  static saveAccessTokenInfo({
    required String accessToken,
  }) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.accessTokenInfo, jsonEncode(decodedToken));
  }

  static Future<DecodeAccessTokenRO?> getAccessTokenInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final accessTokenInfo = prefs.getString(Constants.accessTokenInfo);
    if (accessTokenInfo != null) {
      DecodeAccessTokenRO accessTokenRO =
          DecodeAccessTokenRO.fromJson(jsonDecode(accessTokenInfo));
      return accessTokenRO;
    }
    return null;
  }
}
