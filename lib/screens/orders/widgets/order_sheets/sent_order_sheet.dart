import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

import '../../model.dart';
import 'controller.dart';

class SentOrderSheet extends StatelessWidget {
  final OrderModel? orderModel;
  const SentOrderSheet({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderSheetsController>(
        init: OrderSheetsController(
            orderTypeId: OrderTypeId.delivering, orderModel: orderModel),
        builder: (controller) => Column(
              children: [
                const CustomImage(
                  svgAsset: "assets/images/Frame 2.svg",
                ),
                CustomText(
                  "sent_hint".tr,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          buttonType: ButtonType.text,
                          onPressed: () {
                            controller.sendDeliveredOrder();
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
            ));
  }
}
