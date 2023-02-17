import 'dart:io';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../public_controllers/auth_controller.dart';
import '../utils/constants/styles_and_themes.dart';
import '../utils/custom_widgets/loading_indicator.dart';
import '../utils/translation/translation.dart';

class MyAppController extends GetxController {
  static showLoading() {
    EasyLoading easyLoading = EasyLoading.instance;
    easyLoading.maskColor = Colors.transparent;
    easyLoading.backgroundColor = Colors.red;
    easyLoading.radius = 15;
    easyLoading.contentPadding = EdgeInsets.zero;
    easyLoading.indicatorWidget = const CustomLoadingIndicator();
    EasyLoading.show(
      dismissOnTap: true,
      indicator: easyLoading.indicatorWidget,
      maskType: EasyLoadingMaskType.custom,
    );
  }

  String? deviceToken;
  Map<String, dynamic>? deviceInfo;
  final String deviceType = Platform.operatingSystem;
  Lang lang = Lang.ar;
  ThemeType? theme = ThemeType.light;
  bool firstOpen = true;
  @override
  onInit() {
    initApp();
    super.onInit();
  }

  initApp() async {
    await GetStorage.init();
    await initFCM();
    await getDeviceToken();
    await checkAndUpdateAppLang();
    await checkAndUpdateAppTheme();
    await isFirstOpen();
    print(deviceToken.toString());
    print(deviceType);
    print(lang.toString());
    print(theme.toString());

    AuthController authCTL = Get.find();
    await authCTL.initAuth();
  }

  initFCM() async {
    try {
      await FCMConfig.instance.init(
        defaultAndroidForegroundIcon: '@mipmap/ic_launcher',
        alert: true,
        sound: true,
        announcement: true,
        badge: true,
        criticalAlert: true,
        displayInForeground: (m) => true,
        provisional: true,
        defaultAndroidChannel: const AndroidNotificationChannel(
          'high_importance_channel',
          'nassem mobile app',
          importance: Importance.high,
          sound: RawResourceAndroidNotificationSound('notification'),
        ),
      );
      await FCMConfig.instance.messaging
          .requestPermission(sound: true, alert: true, criticalAlert: true);
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  getDeviceToken() async {
    try {
      return await FCMConfig.instance.messaging
          .getToken()
          .then((value) => changeDeviceToken(value));
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  changeDeviceToken(String? v) {
    deviceToken = v;
    update();
  }

  checkAndUpdateAppLang() async {
    String? l = GetStorage().read("lang");
    if (l != null) {
      await (l == "en" ? changeAppLang(Lang.en) : changeAppLang(Lang.ar));
    } else {
      changeAppLang(Lang.ar);
    }
  }

  changeAppLang(Lang l) async {
    lang = l;
    await GetStorage().write("lang", l == Lang.ar ? "ar" : "en");
    Get.updateLocale(
        l == Lang.ar ? const Locale("ar", "SA") : const Locale("en", "US"));
    update();
  }

  checkAndUpdateAppTheme() async {
    String? t = GetStorage().read("theme");
    if (t != null) {
      theme = await (t == "dark"
          ? changeAppTheme(ThemeType.dark)
          : changeAppTheme(ThemeType.light));
    }
  }

  changeAppTheme(ThemeType? t) async {
    theme = t;
    await GetStorage().write("theme", t == ThemeType.light ? "light" : "dark");
    Get.changeTheme(
        t == ThemeType.light ? ThemeData.light() : ThemeData.dark());
    update();
  }

  isFirstOpen() async {
    bool? first = GetStorage().read("first");
    if (first == null) {
      firstOpen = true;
      update();
      return true;
    } else {
      firstOpen = false;
      update();
      return first;
    }
  }
}
