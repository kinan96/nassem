import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_helpers/validators.dart';
import '../../../utils/custom_widgets/app_logo.dart';
import '../../../utils/custom_widgets/custom_app_bar.dart';
import '../../../utils/custom_widgets/custom_app_screen.dart';
import '../../../utils/custom_widgets/custom_button.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../../../utils/custom_widgets/custom_text_form_field.dart';
import 'controller.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, onWillPop: () async {
        Get.back();
      }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            AppLogo(
              size: Get.width / 3,
              isHero: true,
            ),
            const SizedBox(
              height: 80,
            ),
            CustomText(
              "forget_hint".tr,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                builder: (con) {
                  return Form(
                    key: form,
                    child: CustomTextFormField(
                      controller: con.emailCTL,
                      validator: emailValidate,
                      label: "email".tr,
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                builder: (controller) {
                  return CustomButton(
                    buttonType: ButtonType.text,
                    text: "save".tr,
                    onPressed: () async {
                      await controller.validateScreenThenGoToConfirm(form);
                    },
                  );
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
