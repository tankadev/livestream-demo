import 'package:hitalive/enums/enums.dart';

class UserRO {
  final String uuid;
  final String email;
  final String firstName;
  final String lastName;
  final EAccountVerifyStatus verifyStatus;
  final String birthday;
  final String address;

  UserRO({
    required this.uuid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.verifyStatus,
    required this.birthday,
    required this.address,
  });

  static UserRO fromJson(Map<String, dynamic> json) {
    return UserRO(
      uuid: json['uuid'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthday: json['birthday'] ?? '',
      address: json['address'] ?? '',
      verifyStatus: intToEnumStatus(json['verifyStatus']),
    );
  }

  static EAccountVerifyStatus intToEnumStatus(int input) {
    EAccountVerifyStatus status = EAccountVerifyStatus.init;
    switch (input) {
      case 0:
        status = EAccountVerifyStatus.init;
        break;
      case 1:
        status = EAccountVerifyStatus.pending;
        break;
      case 2:
        status = EAccountVerifyStatus.approved;
        break;
      case 3:
        status = EAccountVerifyStatus.rejected;
        break;
    }
    return status;
  }
}
