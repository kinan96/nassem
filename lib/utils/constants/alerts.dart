import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/custom_app_image.dart';
import '../custom_widgets/custom_text.dart';
import 'colors.dart';
import 'styles_and_themes.dart';

enum AlertType { success, fail, warning }

showCustomSnackBar(
    {@required AlertType? alertType,
    @required String? message,
    int? durationSeconds}) {
  Get.showSnackbar(GetSnackBar(
    isDismissible: true,
    icon: Icon(
      alertType == AlertType.success
          ? Icons.check
          : (alertType == AlertType.fail ? Icons.close : Icons.warning_rounded),
      color: AppColors.white,
    ),
    duration: Duration(seconds: durationSeconds ?? 3),
    message: message ?? "",
    backgroundColor: alertType == AlertType.success
        ? AppColors.primary
        : (alertType == AlertType.fail
            ? AppColors.redBlack
            : AppColors.warning),
  ));
}

showCustomAlertDialog(
    {@required AlertType? alertType,
    @required String? message,
    String? acceptText,
    String? cancelText,
    Function()? onAccept,
    Function()? onCancel,
    int? durationSeconds}) {
  Get.defaultDialog(
      title: "",
      onWillPop: () {
        if (onCancel == null && onAccept != null) {
          onAccept.call();
        } else {
          onCancel?.call();
        }
        Get.back();
        return Future.value(false);
      },
      titleStyle: const TextStyle(fontSize: 0),
      content: Center(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.width / 4,
                height: Get.width / 4,
                child: CustomImage(
                  assetImage: alertType == AlertType.success
                      ? "assets/images/done.gif"
                      : (alertType == AlertType.fail
                          ? "assets/images/wrong-feedback.gif"
                          : "assets/images/alert-animation.gif"),
                ),
              ),
              CustomText(
                message ?? "",
                textAlign: TextAlign.center,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 20),
              ),
              Row(
                children: [
                  onAccept == null
                      ? const SizedBox()
                      : Expanded(
                          child: TextButton(
                            style: buttonStyle(
                                bgColor: alertType == AlertType.success
                                    ? AppColors.primary
                                    : (alertType == AlertType.fail
                                        ? AppColors.redBlack
                                        : AppColors.warning)),
                            onPressed: () {
                              onAccept.call();
                              Get.back();
                            },
                            child: CustomText(
                              acceptText ?? "accept".tr,
                              fontSize: acceptText != null ? 11 : 14,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: onCancel == null ? 0 : 10,
                  ),
                  onCancel == null
                      ? const SizedBox()
                      : Expanded(
                          child: TextButton(
                            style: buttonStyle(
                                bgColor: AppColors.unSelectedGreyContainer),
                            onPressed: () {
                              onCancel.call();
                              Get.back();
                            },
                            child: CustomText(
                              cancelText ?? "cancel".tr,
                              fontSize: acceptText != null ? 11 : 14,
                            ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ));
}
