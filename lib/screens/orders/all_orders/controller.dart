import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/screens/orders/widgets/scan_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan/scan.dart';

class AllOrdersController extends GetxController {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int orderTypeIndex = OrderTypeId.delivering;
  ScanController scanController = ScanController();
  searchWithBarcode() async {
    String? barcode = await Get.to(const BarcodeScanView());
    if (barcode != null) {}
  }
}
