import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'custom_app_image.dart';
import 'custom_button.dart';
import 'custom_text.dart';

AppBar customAppBar(BuildContext context,
    {Function? onWillPop,
    Widget? leading,
    Widget? titleWidget,
    Widget? bottomWidget,
    bool titleHero = false,
    String? titleImageIcon,
    Color backgroundColor = AppColors.background,
    iconImageColor,
    bool? withoutBackButton,
    List<Widget>? actions,
    double? trailingSpace,
    double? bottomHeight,
    double? leadingSpace,
    String? title}) {
  return AppBar(
    titleSpacing: 0,
    bottom: PreferredSize(
      preferredSize:
          Size(Get.width, bottomWidget == null ? 0 : (bottomHeight ?? 65)),
      child: bottomWidget ?? const SizedBox(),
    ),
    backgroundColor: Get.isDarkMode ? AppColors.black : backgroundColor,
    automaticallyImplyLeading: false,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        withoutBackButton != null && withoutBackButton
            ? const SizedBox()
            : CustomButton.back(
                onPressed: onWillPop == null
                    ? () {
                        EasyLoading.dismiss();
                        Get.back();
                      }
                    : () {
                        EasyLoading.dismiss();

                        onWillPop();
                      },
              ),
        SizedBox(
          width: leadingSpace ?? (withoutBackButton == true ? 10 : 0),
        ),
        leading ?? const SizedBox(),
        Expanded(
          child: titleWidget ??
              (title != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        titleImageIcon == null
                            ? const SizedBox()
                            : CustomImage(
                                assetImage: titleImageIcon,
                                color: iconImageColor,
                                height: 20,
                              ),
                        SizedBox(
                          width: titleImageIcon == null ? 0 : 5,
                        ),
                        titleHero
                            ? Hero(
                                tag: title,
                                child: CustomText(
                                  title,
                                  fontSize: 15,
                                  maxLines: 1,
                                  autoSized: true,
                                  color: AppColors.black,
                                  textAlign: TextAlign.start,
                                ),
                              )
                            : CustomText(
                                title,
                                fontSize: 15,
                                maxLines: 1,
                                autoSized: true,
                                color: AppColors.black,
                                textAlign: TextAlign.start,
                              ),
                      ],
                    )
                  : const SizedBox()),
        ),
        Row(
          children: actions ?? [],
        ),
        SizedBox(
          width: trailingSpace ?? (withoutBackButton == true ? 80 : 0),
        )
      ],
    ),
    elevation: 0,
  );
}
