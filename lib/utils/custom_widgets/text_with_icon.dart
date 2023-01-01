import 'package:flutter/material.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'custom_app_image.dart';
import 'custom_text.dart';

class CustomTextWithIconRow extends StatelessWidget {
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double fontSize;
  final double distance;
  final String text;
  final String? imageAsset;
  final String? svgImageAsset;
  final IconData? iconData;
  final bool expandedText;

  const CustomTextWithIconRow({
    Key? key,
    this.iconColor,
    this.distance = 7,
    this.textColor,
    this.iconSize,
    this.fontSize = 14,
    required this.text,
    this.imageAsset,
    this.svgImageAsset,
    this.iconData,
    this.expandedText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconData == null
            ? CustomImage(
                svgAsset: svgImageAsset,
                assetImage: imageAsset,
                height: iconSize ?? 20,
                color: iconColor,
              )
            : Icon(iconData, size: iconSize, color: iconColor),
        SizedBox(
          width: distance,
        ),
        expandedText ? Expanded(child: _text()) : _text(),
      ],
    );
  }

  CustomText _text() {
    return CustomText(
      text,
      color: textColor ?? AppColors.black,
      autoSized: true,
      maxLines: 1,
      fontSize: fontSize,
    );
  }
}
