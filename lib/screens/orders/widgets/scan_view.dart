import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/home/controller.dart';
import 'package:nassem/screens/orders/all_orders/controller.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:scan/scan.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/custom_widgets/custom_app_bar.dart';

class BarcodeScanView extends StatelessWidget {
  const BarcodeScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllOrdersController>(
        init: AllOrdersController(),
        builder: (controller) {
          return CustomAppScreen(
            onWillPop: () {
              Get.back();
            },
            padding: EdgeInsets.zero,
            appBar: customAppBar(
              context,
            ),
            body: ScanView(
              controller: controller.scanController,
              onCapture: (data) {
                Get.back(result: data);
              },
              scanAreaScale: .7,
              scanLineColor: AppColors.primary,
            ),
          );
        });
  }
}
