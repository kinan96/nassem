import 'package:intl/intl.dart';
import 'package:nassem/screens/notifications/model.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../notification_card.dart';
import 'controller.dart';

class AllNotifications extends StatelessWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllNotificationsController>(
        init: AllNotificationsController(),
        builder: (controller) {
          return CustomAppScreen(
            appBar: customAppBar(context,
                title: "notifications".tr, trailingSpace: 40),
            body: SmartRefresher(
              controller: controller.refreshController,
              scrollController: controller.scrollController,
              enablePullUp: true,
              onLoading: () async {
                await controller.onLoadMore();
              },
              onRefresh: () async {
                await controller.onRefresh();
              },
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child:
                    // controller.notifications?.isEmpty == true
                    //     ? SizedBox(
                    //         height: Get.height - 100,
                    //         child: CustomEmptyWidget(
                    //           text: "no_notifications".tr,
                    //         ))
                    //     :
                    Column(
                  children: List.generate(
                      controller.notifications?.length ?? 4,
                      (index) =>
                          // controller.notifications == null
                          //                 ? CustomShimmerBuilder(
                          //                     child: Container(
                          //                         width: Get.width,
                          //                         height: 70,
                          //                         margin:
                          //                             const EdgeInsets.only(bottom: 10),
                          //                         decoration: BoxDecoration(
                          //                             color: AppColors.white,
                          //                             borderRadius:
                          //                                 BorderRadius.circular(10))),
                          //                   )
                          //                 :
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: NotificationCard(
                                onDelete: () {
                                  // controller.deleteNotification(index);
                                },
                                onTap: () {
                                  // controller.onClickNotification(index);
                                },
                                notificationModel: NotificationModel(
                                    body: "شكراً لتوصيل الطلب رقم 2435 بنجاح ",
                                    isRead: index % 2 == 0,
                                    title: "hello",
                                    id: index,
                                    createdAt:
                                        DateFormat.Hm().format(DateTime.now()))
                                // controller.notifications?[index],
                                ),
                          )),
                ),
              ),
            ),
          );
        });
  }
}
