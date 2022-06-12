import 'package:flutter/material.dart';
import 'package:hitalive/configs/configs.dart';

class AppTextStyle {
  /// Small Text
  static const smallText = TextStyle(fontSize: 13, color: AppColor.grey);
  static final smallTextWhite = smallText.copyWith(color: AppColor.white);
  static final smallTextBlack = smallText.copyWith(color: AppColor.black);

  /// Normal Text
  static const normalText = TextStyle(fontSize: 15, color: AppColor.black);
  static final normalTextWhite = normalText.copyWith(color: AppColor.white);
  static final normalTextBoldPrimary = normalText.copyWith(
      color: AppColor.primaryColor, fontWeight: FontWeight.bold);

  /// Medium Text
  static const mediumText = TextStyle(fontSize: 18, color: AppColor.black);
  static final mediumTextBold =
      mediumText.copyWith(fontWeight: FontWeight.bold);
}
