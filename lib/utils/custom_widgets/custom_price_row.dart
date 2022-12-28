import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'custom_text.dart';

class PriceRow extends StatelessWidget {
  final double? price;
  final String? type;
  final String? priceStr;
  final double priceSize;
  final double typeSize;
  final Color? color;
  final MainAxisAlignment mainAxisAlignment;
  const PriceRow(
      {Key? key,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.priceStr,
      this.color,
      this.price,
      this.priceSize = 14,
      this.type,
      this.typeSize = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          priceStr ?? "${price?.toStringAsFixed(2)}",
          color: color ?? AppColors.primary,
          fontSize: priceSize,
        ),
        CustomText(
          type ?? " ${"riyal".tr}",
          height: 2,
          color: color ?? AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: typeSize,
        ),
      ],
    );
  }
}
