import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../public_controllers/auth_controller.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text.dart';

Future<dynamic> logout(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    body: CustomText(
      "logout_msg".tr,
      fontSize: 15,
    ),
    btnCancel: CustomButton(
      buttonType: ButtonType.outlined,
      text: "logout".tr,
      onPressed: () async {
        AuthController auth = Get.find();
        auth.logout();
      },
    ),
    btnOk: CustomButton(
      buttonType: ButtonType.text,
      text: "back".tr,
      onPressed: () {
        Get.back();
      },
    ),
  ).show();
}
