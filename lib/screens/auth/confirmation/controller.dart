import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/public_controllers/auth_controller.dart';

class ConfirmationController extends GetxController {
  TextEditingController codeCTL = TextEditingController();
  resend() async {
    AuthController authController = Get.find();
    await authController.resendForgetPassword();
  }

  activeCode() async {
    AuthController authController = Get.find();
    if (codeCTL.text.length == 4) {
      await authController.activeCode(codeCTL.text);
    }
  }
}
