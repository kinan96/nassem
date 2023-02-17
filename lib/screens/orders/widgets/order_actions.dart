import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/screens/orders/widgets/order_sheets/falt_order_sheet.dart';
import 'package:nassem/utils/constants/bottom_sheet.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/custom_widgets/custom_button.dart';
import 'order_sheets/sent_order_sheet.dart';

class OrderActionsRow extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderActionsRow({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomButton(
                buttonType: ButtonType.text,
                onPressed: () {
                  showCustomBottomSheet(
                    maxHeight: Get.height / (4 / 3),
                    child: SentOrderSheet(
                      orderModel: orderModel,
                    ),
                  );
                },
                text: "sent_delivered_handed".tr)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: CustomButton(
                buttonType: ButtonType.text,
                bgColor: AppColors.yellowWithOpacityColor,
                textColor: AppColors.yellowColor,
                onPressed: () {
                  showCustomBottomSheet(
                    maxHeight: Get.height / (4 / 3),
                    child: FaltOrderSheet(
                      orderModel: orderModel,
                    ),
                    title: "falt_orders".tr,
                  );
                },
                text: "falt_orders".tr)),
      ],
    );
  }
}
