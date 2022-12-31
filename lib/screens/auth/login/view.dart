import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/auth/forget_password/view.dart';
import 'package:nassem/screens/home/view.dart';
import 'package:nassem/utils/custom_helpers/validators.dart';
import '../../../utils/custom_widgets/app_logo.dart';
import '../../../utils/custom_widgets/custom_app_screen.dart';
import '../../../utils/custom_widgets/custom_button.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../../../utils/custom_widgets/custom_text_form_field.dart';
import 'controller.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return CustomAppScreen(
            body: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.mediaQuery.padding.top + 70,
                  ),
                  AppLogo(
                    size: Get.width / 2.5,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomText(
                    "login".tr,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    "login_hint".tr,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextFormField(
                    label: "email".tr,
                    svgIconAsset: "assets/images/sms.svg",
                    validator: emailValidate,
                    controller: controller.emailCTL,
                  ),
                  CustomTextFormField(
                    label: "password".tr,
                    isPassword: true,
                    validator: passwordValidate,
                    controller: controller.passwordCTL,
                  ),
                  Align(
                    alignment: Get.locale?.languageCode == "en"
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: CustomButton(
                      buttonType: ButtonType.inkwell,
                      onPressed: () {
                        Get.to(ForgetPassword());
                      },
                      text: "forget_password".tr,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonType: ButtonType.text,
                    onPressed: () {
                      Get.to(const HomeScreen());
                    },
                    text: "login".tr,
                  )
                ],
              ),
            )),
          );
        });
  }
}
