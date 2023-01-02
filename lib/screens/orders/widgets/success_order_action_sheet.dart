import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class SuccessOrderActionSheet extends StatelessWidget {
  const SuccessOrderActionSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomImage(
          svgAsset: "assets/images/Files sent-rafiki 1.svg",
        ),
        CustomText(
          "request_status_sent".tr,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: CustomButton(
            buttonType: ButtonType.text,
            onPressed: () {
              Get.back();
            },
            text: "continue".tr,
          ),
        ),
      ],
    );
  }
}
