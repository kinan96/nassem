import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllOrdersController extends GetxController {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
}
