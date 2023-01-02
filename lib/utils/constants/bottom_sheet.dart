import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

import 'colors.dart';

showCustomBottomSheet(
    {required Widget child,
    Widget? iconWidget,
    String? title,
    IconData? iconData,
    Color? bgColor,
    double? maxHeight,
    bool hideTopLine = false,
    EdgeInsets? padding,
    Function()? onTapIcon}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: Container(
              constraints: BoxConstraints(
                  maxHeight: maxHeight ?? Get.height / 2, minHeight: 0),
              padding: padding,
              decoration: BoxDecoration(color: bgColor ?? AppColors.white),
              child: SingleChildScrollView(
                  child: Column(children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Spacer(),
                    title == null
                        ? const SizedBox()
                        : CustomText(
                            title,
                            fontSize: 16,
                          ),
                    const Spacer(),
                    iconWidget ??
                        IconButton(
                            onPressed: onTapIcon ??
                                () {
                                  Get.back();
                                },
                            icon: Icon(
                              iconData ?? Icons.close,
                              color: AppColors.grey,
                            ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                child
              ])))),
    ),
    isScrollControlled: true,
  );
}
