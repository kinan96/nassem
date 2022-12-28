import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

showCustomBottomSheet(
    {required Widget child,
    Widget? iconWidget,
    IconData? iconData,
    Color? bgColor,
    double? maxHeight,
    bool hideTopLine = false,
    EdgeInsets? padding,
    Function()? onTapIcon}) {
  Get.bottomSheet(
    Container(
      // height: Get.height / 2,
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              child: Container(
                  constraints: BoxConstraints(
                      maxHeight: maxHeight ?? Get.height / 2, minHeight: 0),
                  padding: padding,
                  decoration: BoxDecoration(color: bgColor ?? AppColors.white),
                  child: SingleChildScrollView(child: child))),
          Positioned(
              top: -20,
              left: 50,
              child: InkWell(
                onTap: onTapIcon ??
                    () {
                      Get.back();
                    },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.secondary,
                  child: iconWidget ??
                      Icon(
                        iconData ?? Icons.close,
                        color: AppColors.white,
                      ),
                ),
              )),
          Offstage(
              offstage: hideTopLine,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: Get.width / 3,
                height: 7,
                decoration: BoxDecoration(
                    color: AppColors.unSelectedGreyContainer,
                    borderRadius: BorderRadius.circular(45)),
              ))
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
