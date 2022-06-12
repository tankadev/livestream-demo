import 'package:hitalive/enums/enums.dart';

class DecodeAccessTokenRO {
  final String email;
  final String uuid;
  final EAccountVerifyStatus verifyStatus;
  final int iat;
  final int exp;

  DecodeAccessTokenRO({
    required this.email,
    required this.uuid,
    required this.verifyStatus,
    required this.iat,
    required this.exp,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, String>{};
    data['email'] = email;
    data['uuid'] = uuid;
    data['verifyStatus'] = _enumStatusToInt(verifyStatus);
    data['iat'] = iat;
    data['exp'] = exp;
    return data;
  }

  static DecodeAccessTokenRO fromJson(Map<String, dynamic> json) {
    return DecodeAccessTokenRO(
      email: json['email'],
      uuid: json['uuid'],
      verifyStatus: _intToEnumStatus(int.parse(json['verifyStatus'])),
      iat: json['iat'] ?? 0,
      exp: json['exp'] ?? 0,
    );
  }

  static EAccountVerifyStatus _intToEnumStatus(int status) {
    EAccountVerifyStatus statusEnum = EAccountVerifyStatus.init;
    switch (status) {
      case 0:
        statusEnum = EAccountVerifyStatus.init;
        break;
      case 1:
        statusEnum = EAccountVerifyStatus.pending;
        break;
      case 2:
        statusEnum = EAccountVerifyStatus.approved;
        break;
      case 3:
        statusEnum = EAccountVerifyStatus.rejected;
        break;
    }
    return statusEnum;
  }

  static int _enumStatusToInt(EAccountVerifyStatus status) {
    int statusNumber = 0;
    switch (status) {
      case EAccountVerifyStatus.init:
        statusNumber = 0;
        break;
      case EAccountVerifyStatus.pending:
        statusNumber = 1;
        break;
      case EAccountVerifyStatus.approved:
        statusNumber = 2;
        break;
      case EAccountVerifyStatus.rejected:
        statusNumber = 3;
        break;
    }
    return statusNumber;
  }
}
