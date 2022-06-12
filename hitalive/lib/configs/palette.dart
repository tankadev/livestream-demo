import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff1a8917, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe4f1e3), //10%
      100: Color(0xffbadcb9), //20%
      200: Color(0xff8dc48b), //30%
      300: Color(0xff5fac5d), //40%
      400: Color(0xff3c9b3a), //50%
      500: Color(0xff1a8917), //60%
      600: Color(0xff178114), //70%
      700: Color(0xff137611), //80%
      800: Color(0xff0f6c0d), //90%
      900: Color(0xff085907), //100%s
    },
  );
}
