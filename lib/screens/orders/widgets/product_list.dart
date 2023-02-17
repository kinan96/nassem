import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_price_row.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class ProductList extends StatelessWidget {
  final OrderDetail? orderDetail;
  const ProductList({super.key, this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImage(
          urlImage: orderDetail?.productDetails?.images?.first.path ?? "",
          width: 70,
          height: 70,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: CustomText(
          (Get.locale?.languageCode == "ar"
                  ? orderDetail?.productDetails?.arName
                  : orderDetail?.productDetails?.enName) ??
              "",
        )),
        const SizedBox(
          width: 10,
        ),
        PriceRow(
          priceStr: orderDetail?.total,
        )
      ],
    );
  }
}
