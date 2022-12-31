import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../model.dart';

class NotificationIconController extends GetxController {
  int unreadCount = 9;
  List<NotificationModel>? notifications;
  String? nextUrl;
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    // await initNotification();
    super.onInit();
  }

  decreaseBadgeCount() {
    if (unreadCount > 0) {
      unreadCount--;
      update();
    }
  }

  initNotification() async {
    unreadCount = await getNotificationBadgeCount();
    update();
    Timer.periodic(const Duration(minutes: 5), (t) async {
      unreadCount = await getNotificationBadgeCount();
      update();
    });
  }

  Future<int> getNotificationBadgeCount() async {
    dio.Response? response = await httpClient.getData(
      url: "home/notification-badge-count",
      dontShowLoading: true,
      dontShowMessage: true,
    );
    if (response != null) {
      return int.tryParse(response.data['data']['count'].toString()) ?? 0;
    }
    return 0;
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
              // nextUrl = (r.paginate?.nextPageUrl == null ||
              //         r.paginate?.nextPageUrl.toString() == "")
              //     ? null
              //     : r.paginate?.nextPageUrl;
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
}
