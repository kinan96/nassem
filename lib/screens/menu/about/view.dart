import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/public_controllers/auth_controller.dart';
import 'package:nassem/screens/menu/about/controller.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, title: "about".tr, titleHero: true),
      body: GetBuilder<AboutController>(
          init: AboutController(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomImage(
                    svgAsset: "assets/images/logo.svg",
                    fit: BoxFit.contain,
                    width: Get.width / 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.data == null
                    ? const LinearProgressIndicator()
                    : CustomText(
                        controller.data ?? "",
                        textAlign: TextAlign.justify,
                        color: AppColors.grey,
                        fontSize: 12,
                      )
              ],
            ));
          }),
    );
  }
}
