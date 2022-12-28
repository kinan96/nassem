import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

enum ThemeType { light, dark }

const String appFontFamily = 'Montserrat-Arabic';

class AppThemes {
  /*


Light Theme



*/

  static ThemeData lightTheme = ThemeData(
      fontFamily: appFontFamily,
      colorScheme: const ColorScheme(
          primary: AppColors.primary,
          primaryContainer: AppColors.primary,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondary,
          surface: AppColors.background,
          background: AppColors.background,
          error: AppColors.red,
          onPrimary: AppColors.white,
          onSecondary: AppColors.white,
          onSurface: AppColors.secondary,
          onBackground: AppColors.secondary,
          onError: AppColors.white,
          brightness: Brightness.light),
      backgroundColor: AppColors.background,
      primarySwatch: generateMaterialColor(AppColors.secondary),
      hintColor: AppColors.textFieldHintText,
      shadowColor: AppColors.textFieldHintText,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
      ),
      indicatorColor: AppColors.secondary,
      scaffoldBackgroundColor: AppColors.background,
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: buttonStyle(outlined: true)),
      textButtonTheme: TextButtonThemeData(style: buttonStyle()),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle()),
      inputDecorationTheme: inputDecorationTheme(),
      buttonTheme: buttonThemeData(),
      appBarTheme: appBarTheme(),
      textTheme: textTheme());

/*


Dark Theme



*/

  static ThemeData darkTheme = ThemeData(
      fontFamily: appFontFamily,
      colorScheme: const ColorScheme(
          primary: AppColors.white,
          primaryContainer: AppColors.black,
          secondary: AppColors.white,
          secondaryContainer: AppColors.black,
          surface: AppColors.background,
          background: AppColors.background,
          error: AppColors.red,
          onPrimary: AppColors.black,
          onSecondary: AppColors.black,
          onSurface: AppColors.white,
          onBackground: AppColors.white,
          onError: AppColors.black,
          brightness: Brightness.dark),
      backgroundColor: AppColors.background,
      primarySwatch: generateMaterialColor(AppColors.greyText),
      hintColor: AppColors.textFieldHintText,
      shadowColor: AppColors.textFieldHintText,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.greyText,
      ),
      indicatorColor: AppColors.greyText,
      scaffoldBackgroundColor: AppColors.background,
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: buttonStyle(outlined: true)),
      textButtonTheme: TextButtonThemeData(style: buttonStyle()),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle()),
      inputDecorationTheme: inputDecorationTheme(),
      buttonTheme: buttonThemeData(),
      appBarTheme: appBarTheme(),
      textTheme: textTheme());
}

/*


Button Style



*/

ButtonStyle buttonStyle(
    {bool outlined = false,
    BorderRadius? borderRadius,
    Color? bgColor,
    borderColor,
    shadowColor,
    double? width,
    height,
    EdgeInsets? padding,
    bool isDark = false}) {
  return ButtonStyle(
    alignment: Alignment.center,
    backgroundColor: MaterialStateProperty.all(
        bgColor ?? (outlined ? Colors.transparent : AppColors.primary)),
    minimumSize:
        MaterialStateProperty.all(Size(width ?? Get.width, height ?? 35)),
    padding: MaterialStateProperty.all(
        padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
    shadowColor:
        MaterialStateProperty.all(shadowColor ?? AppColors.textFieldHintText),
    side: outlined
        ? MaterialStateProperty.all(BorderSide(
            color:
                borderColor ?? (isDark ? AppColors.black : AppColors.secondary),
            width: 1.5))
        : null,
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(5))),
  );
}

/*


Button Theme



*/

ButtonThemeData buttonThemeData() {
  return const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.secondary),
        borderRadius: BorderRadius.all(Radius.circular(5))),
  );
}

/*


Input Decoration



*/

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
      fillColor: AppColors.background,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignLabelWithHint: true,
      disabledBorder: outlineInputBorder(AppColors.secondary),
      enabledBorder: outlineInputBorder(AppColors.secondary),
      focusedBorder: outlineInputBorder(AppColors.secondary),
      errorBorder: outlineInputBorder(AppColors.red),
      focusedErrorBorder: outlineInputBorder(AppColors.red),
      suffixStyle: const TextStyle(
          color: AppColors.textFieldHintText,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      errorStyle: const TextStyle(
          color: AppColors.red, fontSize: 12, fontWeight: FontWeight.bold),
      labelStyle: const TextStyle(
          color: AppColors.textFieldHintText,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      hintStyle: const TextStyle(
          color: AppColors.textFieldHintText,
          fontSize: 12,
          fontWeight: FontWeight.w600));
}

/*


Outline Input Border



*/

OutlineInputBorder outlineInputBorder(Color color,
    {BorderRadius? borderRadius}) {
  return OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(5),
      borderSide: BorderSide(
        color: color,
      ));
}

/*


Text Theme



*/

TextTheme textTheme({Color color = AppColors.black}) {
  return TextTheme(
    subtitle1: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: appFontFamily),
    bodyText2: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: appFontFamily), //inkwell,text
  );
}

/*


AppBar Theme



*/

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: AppColors.secondary,
    iconTheme: IconThemeData(
      color: AppColors.secondary,
      size: 20,
    ),
    centerTitle: true,
    toolbarTextStyle: TextStyle(
        fontFamily: appFontFamily,
        color: AppColors.textFieldHintText,
        fontSize: 15,
        fontWeight: FontWeight.bold), //inkwell,text
    titleTextStyle: TextStyle(
        fontFamily: appFontFamily,
        color: AppColors.textFieldHintText,
        fontSize: 15,
        fontWeight: FontWeight.bold), //tite
  );
}
