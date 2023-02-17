import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/public_controllers/auth_controller.dart';

class NewPasswordController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  setNewPassword(GlobalKey<FormState> form) async {
    if (form.currentState?.validate() == false) {
      return;
    }
    AuthController authController = Get.find();
    await authController.setNewPassword(password.text);
  }
}
