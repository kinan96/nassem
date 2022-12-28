import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_app_image.dart';

enum LogoType { justLogo, withAppName }

class AppLogo extends StatelessWidget {
  final double? size;
  final bool isHero;
  final LogoType logoType;
  final bool justLogo;
  const AppLogo(
      {Key? key,
      this.logoType = LogoType.withAppName,
      this.size,
      this.isHero = true,
      this.justLogo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (isHero) {
      case true:
        return Hero(
          tag: "applogo",
          child: _logo(),
        );
      default:
        return _logo();
    }
  }

  SizedBox _logo() {
    return SizedBox(
        height: size ?? Get.width / 3,
        child: CustomImage(
          fit: BoxFit.fitHeight,
          height: size ?? Get.width / 3,
          svgAsset:
              "assets/images/${logoType == LogoType.justLogo ? "just_logo" : "logo"}.svg",
        ));
  }
}
