import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/my_app/controller.dart';
import 'package:nassem/screens/auth/login/view.dart';
import 'package:nassem/screens/splash/controller.dart';
import 'package:nassem/utils/translation/translation.dart';
import '../../utils/custom_widgets/app_logo.dart';
import '../../utils/custom_widgets/image_title_outlined_button.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: controller.showLogo ? 1 : 0,
                  child: const AppLogo()),
              Positioned(
                  bottom: 10,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInExpo,
                    width:
                        controller.showLangs ? Get.width - 20 : Get.width * 2,
                    child: GetBuilder<MyAppController>(
                        init: MyAppController(),
                        builder: (myApp) {
                          return Row(
                            children: [
                              Expanded(
                                child: CustomImageTitleOtlinedButton(
                                  onPressed: () {
                                    myApp.changeAppLang(Lang.ar);
                                    Get.off(() => Login());
                                  },
                                  imageAsset: "assets/images/sa.svg",
                                  title: "العربية",
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: controller.showLangs ? 10 : Get.width,
                              ),
                              Expanded(
                                child: CustomImageTitleOtlinedButton(
                                  onPressed: () {
                                    myApp.changeAppLang(Lang.en);
                                    Get.off(() => Login());
                                  },
                                  imageAsset: "assets/images/us.svg",
                                  title: "English",
                                ),
                              )
                            ],
                          );
                        }),
                  ))
            ],
          );
        });
  }
}
