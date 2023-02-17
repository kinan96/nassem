import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/main.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/screens/orders/widgets/scan_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan/scan.dart';

class AllOrdersController extends GetxController {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int orderTypeIndex = OrderTypeId.delivering;
  AllOrdersModel? allOrdersModel;
  List<OrderModel>? orders;
  ScanController scanController = ScanController();

  searchWithBarcode() async {
    String? barcode = await Get.to(const BarcodeScanView());
    if (barcode != null) {
      httpClient.postData(
        url: "delivery/assign-to-me/$barcode",
        body: {},
        onSuccess: (responseJson) {
          getOrders();
        },
      );
    }
  }

  getOrders({String? next}) {
    if (next == null) {
      allOrdersModel = null;
      orders = null;
      update();
    }
    httpClient.getData(
      fullUrl: next,
      url: orderTypeIndex == OrderTypeId.delivering
          ? "delivery/on-the-way-orders"
          : (orderTypeIndex == OrderTypeId.stalled
              ? "delivery/delivery-miss-orders"
              : "delivery/delivered-orders"),
      dontShowLoading: true,
      dontShowMessage: true,
      onSuccess: (responseJson) {
        allOrdersModel = AllOrdersModel.fromJson(responseJson?['data']);
        if (next == null) {
          orders = allOrdersModel?.list;
        } else {
          orders?.addAll(allOrdersModel?.list ?? []);
        }
        update();
      },
    );
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
}
