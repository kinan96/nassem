import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/widgets/success_order_action_sheet.dart';
import 'package:nassem/utils/constants/bottom_sheet.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class SentOrderSheet extends StatelessWidget {
  const SentOrderSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomImage(
          svgAsset: "assets/images/Frame 2.svg",
        ),
        CustomText(
          "sent_hint".tr,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonType: ButtonType.text,
                  onPressed: () {
                    Get.back();
                    showCustomBottomSheet(
                        child: const SuccessOrderActionSheet());
                  },
                  text: "yes".tr,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomButton(
                  buttonType: ButtonType.outlined,
                  onPressed: () {
                    Get.back();
                  },
                  text: "no".tr,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
