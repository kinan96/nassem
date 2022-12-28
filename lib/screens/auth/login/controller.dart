import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../public_controllers/auth_controller.dart';

class LoginController extends GetxController {
  TextEditingController emailCTL = TextEditingController();
  TextEditingController passwordCTL = TextEditingController();

  login(GlobalKey<FormState> formKey) {
    formKey.currentState?.save();
    if (formKey.currentState?.validate() == false) {
      return;
    }
    AuthController authController = Get.find();
    authController.login(email: emailCTL.text, password: passwordCTL.text);
  }
}
