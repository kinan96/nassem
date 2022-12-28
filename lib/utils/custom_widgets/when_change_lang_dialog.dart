import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app/controller.dart';
import '../constants/colors.dart';
import '../translation/translation.dart';
import 'custom_app_image.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class WhenChangeLangDialog extends StatelessWidget {
  const WhenChangeLangDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppController>(
        init: MyAppController(),
        builder: (controller) {
          return Column(
            children: [
              CustomButton(
                onPressed: () async {
                  await controller.changeAppLang(Lang.ar);
                  await controller.initApp();
                },
                buttonType: ButtonType.inkwell,
                child: Row(
                  children: [
                    const CustomImage(
                      assetImage: "assets/images/ksaflag.png",
                      height: 20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(child: CustomText("العربية")),
                    Icon(
                      Get.locale?.languageCode == "ar"
                          ? Icons.radio_button_checked_outlined
                          : Icons.radio_button_off,
                      color: Get.locale?.languageCode == "ar"
                          ? AppColors.secondary
                          : AppColors.unSelectedGreyContainer,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Divider(
                  thickness: 2,
                ),
              ),
              CustomButton(
                onPressed: () async {
                  await controller.changeAppLang(Lang.en);
                  await controller.initApp();
                },
                buttonType: ButtonType.inkwell,
                child: Row(
                  children: [
                    const CustomImage(
                      assetImage: "assets/images/ukflag.png",
                      height: 20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(child: CustomText("English")),
                    Icon(
                      Get.locale?.languageCode == "en"
                          ? Icons.radio_button_checked_outlined
                          : Icons.radio_button_off,
                      color: Get.locale?.languageCode == "en"
                          ? AppColors.secondary
                          : AppColors.unSelectedGreyContainer,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
