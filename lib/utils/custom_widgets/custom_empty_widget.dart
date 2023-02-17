import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'custom_app_image.dart';
import 'custom_text.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? image;
  final String? text;
  final double? imageWidth;
  final bool isExpandedImage;
  final double opacity;
  final Color? textColor;
  const CustomEmptyWidget(
      {Key? key,
      this.isExpandedImage = false,
      this.imageWidth,
      this.textColor,
      this.opacity = 0.2,
      this.image,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isExpandedImage
              ? Expanded(child: _image())
              : SizedBox(width: imageWidth ?? Get.width / 2, child: _image()),
          CustomText(
            text ?? "no_results".tr,
            fontSize: 14,
            color: textColor ?? AppColors.greyText,
            fontWeight: FontWeight.w600,
            padding: const EdgeInsets.only(bottom: 10),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return Opacity(
      opacity: opacity,
      child: CustomImage(
        svgAsset: image ?? "assets/images/logo.svg",
        fit: BoxFit.contain,
        width: imageWidth ?? Get.width / 2,
      ),
    );
  }
}
