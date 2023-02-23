import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/public_controllers/auth_controller.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class Account extends StatelessWidget {
  Account({super.key});
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return CustomAppScreen(
            appBar: customAppBar(context, title: "personal_account".tr),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CustomImage(
                    urlImage: controller.userModel?.image,
                    width: Get.width / 3,
                    height: Get.width / 3,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(controller.userModel?.name ?? ""),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width,
                      ),
                      CustomText("account_details".tr),
                      const SizedBox(
                        height: 10,
                      ),
                      AccountDataRow(
                        iconSVG: "assets/images/sms.svg",
                        data: controller.userModel?.email ?? "",
                      ),
                      AccountDataRow(
                        iconSVG: "assets/images/mobile.svg",
                        data: controller.userModel?.phone ?? "",
                      ),
                      AccountDataRow(
                        iconSVG: "assets/images/location.svg",
                        data: controller.userModel?.address ?? "",
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        });
  }
}

class AccountDataRow extends StatelessWidget {
  final String iconSVG;
  final String data;
  const AccountDataRow({
    super.key,
    required this.iconSVG,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: data.isEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            CustomImage(
              svgAsset: iconSVG,
              color: AppColors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomText(
                data,
                color: AppColors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
