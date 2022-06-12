import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hitalive/configs/configs.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primarySwatch: Palette.kToDark,
  // primaryColorDark: const Color(0xFF0097A7),
  // primaryColorLight: const Color(0xFFB2EBF2),
  // primaryColor: const Color(0xFF00BCD4),
  // colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColor.white90,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.grey90),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(
        width: 1,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.0,
      horizontal: 10.0,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      primary: AppColor.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: TextStyle(color: AppColor.black, fontSize: 20),
        pickerTextStyle: TextStyle(color: AppColor.black, fontSize: 20),
      )
  )
);
