import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/wallet/model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/custom_widgets/custom_app_image.dart';
import '../../../utils/custom_widgets/custom_price_row.dart';
import '../../../utils/custom_widgets/custom_text.dart';

class WalletInfoCard extends StatelessWidget {
  final int walletStatusId;
  const WalletInfoCard({
    Key? key,
    this.walletStatusId = WalletStatusId.indebtedness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(width: .35, color: AppColors.unSelectedGreyContainer)),
      child: Column(
        children: [
          Row(
            children: [
              CustomImage(
                svgAsset: getImageByStatus(),
                height: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: CustomText(getTitleByStatus()))
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: Divider(),
          ),
          const PriceRow(
            mainAxisAlignment: MainAxisAlignment.start,
            price: 100,
            priceSize: 18,
            typeSize: 12,
            color: AppColors.black,
          )
        ],
      ),
    );
  }

  String getImageByStatus() {
    switch (walletStatusId) {
      case 0:
        return "assets/images/Frame.svg";
      case 1:
        return "assets/images/Frame-1.svg";

      case 2:
        return "assets/images/Frame-2.svg";

      case 3:
        return "assets/images/Frame-3.svg";

      default:
        return "assets/images/Frame.svg";
    }
  }

  String getTitleByStatus() {
    switch (walletStatusId) {
      case 0:
        return "current_indebtedness".tr;
      case 1:
        return "cash_requests".tr;

      case 2:
        return "online_requests".tr;

      case 3:
        return "total_orders".tr;

      default:
        return "current_indebtedness".tr;
    }
  }
}
