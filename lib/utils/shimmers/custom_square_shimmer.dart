import 'package:flutter/material.dart';
import '../constants/colors.dart';
import './custom_shimmer_builder.dart';

class CustomSquareShimmer extends StatelessWidget {
  final double? width, height;
  const CustomSquareShimmer({Key? key, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmerBuilder(
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
      ),
    );
  }
}
