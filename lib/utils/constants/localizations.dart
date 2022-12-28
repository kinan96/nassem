import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const List<Locale> supportedLocales = [
  Locale('en', 'US'),
  Locale('ar', 'SA'),
];

const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegate = [
  GlobalWidgetsLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  DefaultMaterialLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  ...GlobalCupertinoLocalizations.delegates
];

Locale? localeResolutionCallback(
    Locale? locale, Iterable<Locale> supportedLocales) {
  for (var supportedLocaleLanguage in supportedLocales) {
    if (supportedLocaleLanguage.languageCode == locale?.languageCode &&
        supportedLocaleLanguage.countryCode == locale?.countryCode) {
      return supportedLocaleLanguage;
    }
  }
  return supportedLocales.first;
}
