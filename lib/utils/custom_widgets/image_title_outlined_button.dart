import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_app_image.dart';
import 'custom_text.dart';

class CustomImageTitleOtlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final String imageAsset;
  final String title;
  const CustomImageTitleOtlinedButton({
    Key? key,
    this.onPressed,
    required this.imageAsset,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(svgAsset: imageAsset),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              title,
              color: AppColors.primary,
            )
          ],
        ));
  }
}
