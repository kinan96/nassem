import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

Future<bool> whenExitApp() async {
  Get.defaultDialog(
    title: "انتبه",
    titleStyle: const TextStyle(
      fontSize: 18,
      color: Colors.red,
    ),
    middleText: "هل تريد إغلاق التطبيق؟",
    middleTextStyle: const TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    confirmTextColor: AppColors.white,
    textConfirm: "نعم",
    textCancel: "لا",
    onConfirm: () {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    },
    onCancel: () {},
  );

  return Future.value(false);
}
