import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../../utils/custom_widgets/custom_app_image.dart';
import 'model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel? notificationModel;
  final Function()? onTap;
  final Function()? onDelete;
  const NotificationCard(
      {Key? key, this.onTap, this.notificationModel, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            onDelete?.call();
          },
          autoClose: true,
          spacing: 40,
          backgroundColor: AppColors.background,
          icon: Icons.delete,
          foregroundColor: AppColors.red,
        )
      ]),
      child: CustomButton(
        buttonType: ButtonType.inkwell,
        onPressed: onTap,
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: notificationModel?.isRead == true
                    ? null
                    : const [
                        BoxShadow(
                            color: AppColors.primary,
                            blurRadius: 0,
                            spreadRadius: 0,
                            offset: Offset(-2, 0))
                      ],
                color: notificationModel?.isRead == true
                    ? AppColors.unSelectedGreyContainer.withOpacity(.1)
                    : AppColors.primaryWithOpacity),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: notificationModel?.isRead == true
                          ? AppColors.unSelectedGreyContainer.withOpacity(.2)
                          : AppColors.primary.withOpacity(.2)),
                  child: CustomImage(
                    svgAsset: "assets/images/receipt-add.svg",
                    color: notificationModel?.isRead == true
                        ? AppColors.unSelectedGreyContainer
                        : AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        (Get.locale?.languageCode == "ar"
                                ? notificationModel?.body
                                : notificationModel?.enBody) ??
                            "",
                        fontSize: 14,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 5,
                      ),
                      CustomText(
                        notificationModel?.createdAt ?? "",
                        autoSized: true,
                        maxLines: 1,
                        color: AppColors.unSelectedGreyContainer,
                        maxWidth: Get.width / 5,
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
