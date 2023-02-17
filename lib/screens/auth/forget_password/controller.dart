import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../public_controllers/auth_controller.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController emailCTL;
  @override
  onInit() {
    emailCTL = TextEditingController();
    super.onInit();
  }

  validateScreenThenGoToConfirm(GlobalKey<FormState> form) async {
    if (form.currentState?.validate() == false) {
      update();
      return;
    } else {
      AuthController _auth = Get.find();
      await _auth.forgetPassword(emailCTL.text);
    }
  }
}
