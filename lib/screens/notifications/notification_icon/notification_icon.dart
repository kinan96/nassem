import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../public_controllers/auth_controller.dart';
import '../../../public_controllers/notifications_controller.dart';
import '../../../utils/constants/colors.dart';
import '../all_notifications/all_notifications.dart';
import 'controller.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  @override
  Widget build(BuildContext context) {
    return FCMNotificationListener(
      onNotification: (notification, setState) {},
      child: FCMNotificationClickListener(
        onNotificationClick: (notification, setState) {
          AllNotificationsController.onClickFCMNotification(notification);
        },
        child: GetBuilder<AuthController>(builder: (auth) {
          return GetBuilder<NotificationIconController>(
              init: NotificationIconController(),
              builder: (controller) => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomButton(
                        buttonType: ButtonType.icon,
                        onPressed: () {
                          Get.to(() => const AllNotifications());
                        },
                        iconColor: controller.unreadCount > 0
                            ? AppColors.red
                            : AppColors.primary,
                        svgImageIcon: "assets/images/notification-bing.svg",
                      ),
                      controller.unreadCount > 0
                          ? Positioned(
                              right: -7,
                              bottom: -7,
                              child: Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryWithOpacity,
                                    borderRadius: BorderRadius.circular(90),
                                    border: Border.all(
                                        color: AppColors.white, width: 1)),
                                child: CustomText(
                                  "${controller.unreadCount}",
                                  color: AppColors.red,
                                  autoSized: true,
                                  maxLines: 1,
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ));
        }),
      ),
    );
  }
}
