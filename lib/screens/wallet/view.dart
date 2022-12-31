import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/wallet/controller.dart';
import 'package:nassem/screens/wallet/model.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../utils/constants/colors.dart';
import 'widgets/wallet_info_card.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
        vsync: this, initialIndex: WalletStatusId.indebtedness, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
        init: WalletController(),
        builder: (controller) {
          return CustomAppScreen(
            body: Column(children: [
              SizedBox(
                height: Get.mediaQuery.padding.top + 20,
              ),
              SizedBox(
                width: Get.width,
                child: TabBar(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    controller: tabController,
                    onTap: (value) {
                      controller.walletStatusId = value;
                      controller.update();
                    },
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.blackGrey,
                    isScrollable: true,
                    indicatorPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    indicator: RectangularIndicator(
                        paintingStyle: PaintingStyle.fill,
                        strokeWidth: 1,
                        color: AppColors.primaryWithOpacity,
                        bottomLeftRadius: 10,
                        bottomRightRadius: 10,
                        topLeftRadius: 10,
                        topRightRadius: 10),
                    tabs: [
                      Tab(
                        text: "indebtedness".tr,
                      ),
                      Tab(
                        text: "cash".tr,
                      ),
                      Tab(
                        text: "online_requests".tr,
                      ),
                      Tab(
                        text: "total".tr,
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              WalletInfoCard(
                walletStatusId: controller.walletStatusId,
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: .35, color: AppColors.unSelectedGreyContainer)),
                child: SfSparkLineChart(
                  axisLineColor: AppColors.background,
                  color: AppColors.primary,
                  trackball: const SparkChartTrackball(
                      color: AppColors.primary,
                      backgroundColor: AppColors.primary,
                      activationMode: SparkChartActivationMode.tap),
                  marker: const SparkChartMarker(
                      color: AppColors.primary,
                      borderColor: AppColors.primary,
                      displayMode: SparkChartMarkerDisplayMode.all),
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  data: const [100, 600, 200, 100, 308, 700, 500, 540],
                ),
              )),
              const SizedBox(
                height: 20,
              ),
            ]),
          );
        });
  }
}
