import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/when_change_lang_dialog.dart';

Future<bool> whenChangeLang() async {
  Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: const EdgeInsets.only(top: 15),
      content: const WhenChangeLangDialog());

  return Future.value(false);
}
