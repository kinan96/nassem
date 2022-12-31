import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model.dart';
import '../notification_icon/controller.dart';

class AllNotificationsController extends GetxController {
  List<NotificationModel>? notifications;
  String? nextUrl;
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    // getData();
    super.onInit();
  }

  onRefresh() async {
    await getData();
    refreshController.refreshCompleted();
  }

  onLoadMore() async {
    if (nextUrl != null) {
      await getData(next: nextUrl);
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  getData({String? next}) async {
    try {
      if (next == null) {
        notifications = null;
        nextUrl = null;
        update();
      }
      await httpClient.getData(
          url: "notifications",
          fullUrl: next,
          dontShowLoading: true,
          dontShowMessage: true,
          onSuccess: (body) async {
            if (body?['data'].runtimeType != List) {
              AllNotificationsModel all =
                  AllNotificationsModel.fromJson(body?['data']);
              if (next == null) {
                notifications = all.data;
              } else {
                (notifications ?? []).addAll(all.data);
              }
            } else {
              notifications = [];
              nextUrl = null;
            }
            update();
          },
          onError: (b) {
            notifications = [];
            nextUrl = null;
            update();
          });
    } catch (_) {}
  }

  markAsRead(int id) async {
    try {
      await httpClient.postData(
        url: "notifications/mark-as-read/$id",
        dontShowLoading: true,
        dontShowMessage: true,
        body: {},
      );
    } catch (_) {}
  }

  deleteNotification(int index) async {
    try {
      await httpClient.postData(
          url: "notifications/delete/${notifications?[index].id}",
          dontShowLoading: true,
          dontShowMessage: true,
          body: {},
          onSuccess: (b) {
            notifications?.removeAt(index);
            update();
          });
    } catch (_) {}
  }

  readNotification(int index) async {
    if (notifications?[index].isRead == false) {
      notifications?[index].isRead = true;
      update();
      await markAsRead(notifications?[index].id ?? 0);
      NotificationIconController icon = Get.find();
      icon.decreaseBadgeCount();
    }
  }

  onClickNotification(int index) async {
    readNotification(index);
  }

  static onClickFCMNotification(RemoteMessage remoteMessage) async {}
}
