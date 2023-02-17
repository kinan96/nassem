import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/auth/login/view.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_helpers/validators.dart';
import 'package:nassem/utils/custom_widgets/app_logo.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:nassem/utils/custom_widgets/custom_text_form_field.dart';

import 'controller.dart';

class NewPassword extends StatelessWidget {
  NewPassword({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, title: "set_new_password".tr),
      body: GetBuilder<NewPasswordController>(
        init: NewPasswordController(),
        builder: (controller) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const AppLogo(),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    "new_pass_hint".tr,
                    fontSize: 12,
                    color: AppColors.blackGrey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomImage(
                    svgAsset: "assets/images/q.svg",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                    controller: controller.password,
                    validator: (v) => doublePasswordValidate(
                        controller.password.text, controller.rePassword.text),
                    label: "new_password".tr,
                    isPassword: true,
                  ),
                  CustomTextFormField(
                    controller: controller.rePassword,
                    validator: (v) => doublePasswordValidate(
                        controller.rePassword.text, controller.password.text),
                    isPassword: true,
                    label: "reset_pass".tr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonType: ButtonType.text,
                    text: "set_pass".tr,
                    onPressed: () {
                      controller.setNewPassword(formKey);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
