import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/auth/account/view.dart';
import 'package:nassem/screens/menu/terms/view.dart';
import 'package:nassem/screens/menu/widgets.dart/app_version.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_helpers/logout.dart';
import 'package:nassem/utils/custom_helpers/when_change_lang.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';

import 'package:nassem/utils/custom_widgets/custom_text.dart';

import 'about/view.dart';
import 'widgets.dart/menu_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, withoutBackButton: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "menu".tr,
            fontSize: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MenuButton(
                  onPressed: () {
                    Get.to(Account());
                  },
                  text: "personal_account".tr,
                  svgAsset: "assets/images/profile.svg",
                ),
                const SizedBox(
                  height: 10,
                ),
                MenuButton(
                  onPressed: () {
                    whenChangeLang();
                  },
                  text: "change_lang".tr,
                  svgAsset: "assets/images/language-circle.svg",
                ),
                const SizedBox(
                  height: 10,
                ),
                MenuButton(
                  onPressed: () {
                    Get.to(const About());
                  },
                  text: "about".tr,
                  svgAsset: "assets/images/information.svg",
                ),
                const SizedBox(
                  height: 10,
                ),
                MenuButton(
                  onPressed: () {
                    Get.to(const Terms());
                  },
                  text: "terms".tr,
                  svgAsset: "assets/images/security-safe.svg",
                ),
                const SizedBox(
                  height: 10,
                ),
                MenuButton(
                  onPressed: () {
                    logout(context);
                  },
                  color: AppColors.red,
                  text: "sign_out".tr,
                  svgAsset: "assets/images/logout.svg",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
          const Center(child: AppVersionWidget()),
        ],
      ),
    );
  }
}
