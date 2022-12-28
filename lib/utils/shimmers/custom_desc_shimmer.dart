import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'custom_shimmer_builder.dart';

class CustomDescShimmer extends StatelessWidget {
  const CustomDescShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmerBuilder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            height: 10,
            color: AppColors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            height: 10,
            color: AppColors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width / 2,
            height: 10,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
