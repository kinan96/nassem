import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/widgets/falt_order_sheet.dart';
import 'package:nassem/utils/constants/bottom_sheet.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/custom_widgets/custom_button.dart';
import 'sent_order_sheet.dart';

class OrderActionsRow extends StatelessWidget {
  const OrderActionsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomButton(
                buttonType: ButtonType.text,
                onPressed: () {
                  showCustomBottomSheet(child: const SentOrderSheet());
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
                  showCustomBottomSheet(child: const FaltOrderSheet());
                },
                text: "falt_orders".tr)),
      ],
    );
  }
}
