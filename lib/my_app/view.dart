import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../public_controllers/my_bindings.dart';
import '../screens/splash/view.dart';
import '../utils/constants/localizations.dart';
import '../utils/constants/styles_and_themes.dart';
import '../utils/translation/translation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Splash(),
      initialBinding: MyBindings(),
      defaultTransition: Transition.leftToRight,
      title: "app_name".tr,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.lightTheme,
      builder: EasyLoading.init(),
      locale: const Locale("ar", "SA"),
      translations: AppTranslation(),
      debugShowCheckedModeBanner: false,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegate,
      localeResolutionCallback: localeResolutionCallback,
    );
  }
}
