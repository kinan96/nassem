import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/screens/orders/order_page/view.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

import '../../../utils/custom_widgets/text_with_icon.dart';
import 'order_actions.dart';

class OrderCard extends StatelessWidget {
  final int orderTypeId;
  final OrderModel? orderModel;
  const OrderCard(
      {super.key, this.orderModel, this.orderTypeId = OrderTypeId.delivering});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        borderColor: AppColors.primaryWithOpacity,
        buttonType: ButtonType.outlined,
        padding: const EdgeInsets.all(10),
        onPressed: () {
          if (orderModel != null) {
            Get.to(OrderPage(
              orderTypeId: orderTypeId,
              orderModel: orderModel,
            ));
          }
        },
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
                      "${"order".tr} ${orderModel?.id ?? ""}",
                      fontSize: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      "${orderModel?.total ?? ""} ${"riyal".tr}",
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
                Expanded(
                    child: CustomTextWithIconRow(
                  expandedText: true,
                  svgImageAsset: "assets/images/wallet-money.svg",
                  text: getPaymentMethodName(orderModel?.paymentMethod),
                )),
                CustomTextWithIconRow(
                  svgImageAsset: "assets/images/profile-circle.svg",
                  text: orderModel?.receiverName ?? "",
                ),
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
                  OrderActionsRow(
                    orderModel: orderModel,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
