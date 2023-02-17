import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';

class CustomShimmerBuilder extends StatelessWidget {
  final Widget child;
  const CustomShimmerBuilder({Key? key, this.child = const SizedBox()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.white.withOpacity(.9),
        highlightColor: AppColors.primary, //Colors.grey[100],
        enabled: true,
        child: child);
  }
}
