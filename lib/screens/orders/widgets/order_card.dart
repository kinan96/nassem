import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class OrderCard extends StatelessWidget {
  final int orderTypeId;

  const OrderCard({super.key, this.orderTypeId = OrderTypeId.delivering});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        borderColor: AppColors.primaryWithOpacity,
        buttonType: ButtonType.outlined,
        padding: const EdgeInsets.all(10),
        onPressed: () {},
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: Get.width / 7,
                  height: Get.width / 7,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryWithOpacity),
                  child: const CustomImage(
                    svgAsset: "assets/images/just_logo.svg",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    CustomText(
                      "${"order".tr} 123",
                      fontSize: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      "120 ${"riyal".tr}",
                      fontSize: 15,
                      color: AppColors.primary,
                    )
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(5),
              child: Divider(),
            ),
            Row(
              children: [
                const CustomImage(
                  svgAsset: "assets/images/wallet-money.svg",
                  height: 20,
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(child: CustomText("payment_upon_receipt".tr)),
                const CustomImage(
                  svgAsset: "assets/images/profile-circle.svg",
                  height: 20,
                ),
                const SizedBox(
                  width: 7,
                ),
                const CustomText("مصطفى باشا القديم")
              ],
            ),
            Offstage(
              offstage: orderTypeId != OrderTypeId.delivering,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                              buttonType: ButtonType.text,
                              onPressed: () {},
                              text: "sent_delivered_handed".tr)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomButton(
                              buttonType: ButtonType.text,
                              bgColor: AppColors.yellowWithOpacityColor,
                              textColor: AppColors.yellowColor,
                              onPressed: () {},
                              text: "falt_orders".tr)),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
