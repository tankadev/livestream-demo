import 'dart:io';

import 'package:dio/dio.dart';

class VerifyInfoDTO {
  final String firstName;
  final String lastName;
  final String address;
  final String birthday;
  final File? image;

  VerifyInfoDTO({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.birthday,
    required this.image,
  });

  static VerifyInfoDTO fromJson(Map<String, dynamic> json, File? image) {
    return VerifyInfoDTO(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      address: json['address'] ?? '',
      birthday: json['birthday'] ?? '',
      image: image,
    );
  }

  Future<FormData> toFormData() async {
    if (image != null) {
      String fileName = image!.path.split('/').last;
      FormData data = FormData.fromMap({
        'imageFile': await MultipartFile.fromFile(
          image!.path,
          filename: fileName,
        ),
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'birthday': birthday,
      });
      return data;
    } else {
      throw ('Không có hình ảnh');
    }
  }
}
