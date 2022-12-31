import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/auth/forget_password/controller.dart';
import 'package:nassem/screens/auth/new_password/view.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/app_logo.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, title: "validation_code".tr),
      body: GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
        builder: (controller) {
          return SingleChildScrollView(
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
                  "confirm_hint".tr,
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
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    onChanged: (v) {},
                    autoDismissKeyboard: true,
                    enablePinAutofill: true,
                    autoFocus: true,
                    controller: controller.codeCTL,
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.primary,
                    textStyle: const TextStyle(color: AppColors.primary),
                    pinTheme: PinTheme(
                      inactiveFillColor: AppColors.primary.withOpacity(.2),
                      disabledColor: AppColors.primary.withOpacity(.2),
                      inactiveColor: AppColors.primary.withOpacity(.2),
                      selectedFillColor: AppColors.greenColor,
                      fieldWidth: (Get.width - 40) / 4,
                      borderRadius: BorderRadius.circular(10),
                      shape: PinCodeFieldShape.box,
                      activeColor: AppColors.primary.withOpacity(.2),
                      errorBorderColor: AppColors.red,
                      selectedColor: AppColors.primary,
                      activeFillColor: AppColors.primary.withOpacity(.2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonType: ButtonType.text,
                  text: "achieve".tr,
                  onPressed: () {
                    Get.to(NewPassword());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
