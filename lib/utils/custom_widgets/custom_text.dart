import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final Function()? onTap;
  final double fontSize;
  final TextAlign textAlign;
  final Color? color;
  final TextDirection? textDirection;
  final int? maxLines;
  final double? maxWidth;
  final FontWeight fontWeight;
  final double height;
  final bool autoSized;
  final Color? darkModeColor;
  final TextDecoration textDecoration;
  const CustomText(this.text,
      {Key? key,
      this.textDecoration = TextDecoration.none,
      this.darkModeColor,
      this.autoSized = false,
      this.onTap,
      this.textAlign = TextAlign.start,
      this.maxWidth,
      this.height = 1.5,
      this.textDirection,
      this.fontWeight = FontWeight.normal,
      this.padding,
      this.color,
      this.fontSize = 14,
      this.maxLines})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: maxWidth ?? Get.width, minWidth: 0),
        child: !autoSized
            ? Text(
                text,
                textAlign: textAlign,
                textDirection: textDirection ??
                    (Get.locale == const Locale("ar", "SA")
                        ? TextDirection.rtl
                        : TextDirection.ltr),
                style: TextStyle(
                    color: Get.isDarkMode
                        ? darkModeColor ?? Colors.white
                        : (color ?? Colors.black),
                    height: height,
                    fontFamily: "Montserrat-Arabic",
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    decoration: textDecoration),
              )
            : AutoSizeText(
                text,
                maxFontSize: 20,
                minFontSize: 5,
                textDirection: textDirection ??
                    (Get.locale == const Locale("ar", "SA")
                        ? TextDirection.rtl
                        : TextDirection.ltr),
                textAlign: textAlign,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
                style: TextStyle(
                    color:
                        Get.isDarkMode ? darkModeColor ?? Colors.white : color,
                    height: height,
                    fontFamily: "Montserrat-Arabic",
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    decoration: textDecoration),
              ),
      ),
    );
  }
}
