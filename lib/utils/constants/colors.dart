import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(214, 133, 114, 1);
  static const Color grey = Color(0xff666666);

  static const Color greyContainer = Color.fromARGB(255, 236, 236, 236);
  static const Color greenColor = Color(0xff25D366);
  static const Color yellowColor = Color(0xffEBBC2E);
  static const Color yellowWithOpacityColor = Color(0xffFDF9EC);
  static const Color primaryWithOpacity = Color(0xffFAF1EF);
  static const Color whiteCard = Color(0xffD4E2D6);
  static const Color unselectedPrimary = Color(0xffC0CEC2);
  static const Color primaryBlack = Color(0xff287E30);
  static const Color greenText = Color(0xff7E9682);
  static const Color secondary = Color(0xffFAF1EF);
  static const Color secondaryBlack = Color(0xff0F1322);
  static const Color warning = Color(0xffFFB93C);
  static const Color warningBlack = Color(0xffF4A20E);
  static const Color red = Color(0xffFF375E);
  static const Color redBlack = Color(0xffE7212D);
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xff1B1C1E);
  static const Color blackText = Color(0xff0D130E);
  static const Color white = Color(0xffFFFFFF);
  static const Color background = Color.fromARGB(15, 255, 255, 255);
  static const Color textFieldHintText = Color(0xff5D719C);
  static const Color textUnSelectedGreyText = Color.fromARGB(77, 27, 28, 30);
  static const Color unSelectedGreyContainer = Color(0xffCBCBCB);
  static const Color greyText = Color(0xffB6C9D9);
  static const Color blackGrey = Color(0xff999999);
  static const Color redWith10Opacity = Color.fromARGB(26, 176, 0, 32);
  static const Color greenWith10Opacity = Color.fromARGB(26, 119, 243, 81);
  static const Color blackColorForGradient1 = Color(0xff444F67);
  static const Color blackColorForGradient2 = Color(0xff1B202D);
  static const Gradient primaryGradient = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        primary,
        primary,
        primaryBlack,
      ]);
  static const Gradient blackGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        primary,
        secondary,
      ]);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
