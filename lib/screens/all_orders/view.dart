import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/all_orders/controller.dart';
import 'package:nassem/screens/auth/login/view.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../utils/constants/colors.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllOrdersController>(
        init: AllOrdersController(),
        builder: (controller) {
          return CustomAppScreen(
            body: Column(
              children: [
                SizedBox(
                  height: Get.mediaQuery.padding.top + 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "welcome".tr,
                          color: AppColors.blackGrey,
                          fontSize: 12,
                        ),
                        CustomText(
                          "فيصل",
                          color: AppColors.primary,
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      buttonType: ButtonType.icon,
                      onPressed: () {},
                      iconColor: AppColors.primary,
                      svgImageIcon: "assets/images/notification-bing.svg",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      buttonType: ButtonType.icon,
                      iconColor: AppColors.primary,
                      onPressed: () {},
                      svgImageIcon: "assets/images/scan-barcode.svg",
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width,
                  child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                      controller: tabController,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.blackGrey,
                      isScrollable: true,
                      indicatorPadding: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      indicator: RectangularIndicator(
                          paintingStyle: PaintingStyle.fill,
                          color: AppColors.primaryWithOpacity,
                          bottomLeftRadius: 10,
                          bottomRightRadius: 10,
                          topLeftRadius: 10,
                          topRightRadius: 10),
                      tabs: [
                        Tab(
                          text: "delivery_in_progress".tr,
                        ),
                        Tab(
                          text: "stalled_requests".tr,
                        ),
                        Tab(
                          text: "delivered".tr,
                        )
                      ]),
                ),
                Expanded(
                    child: SmartRefresher(
                  controller: controller.refreshController,
                  scrollController: controller.scrollController,
                  child: ListView(
                    controller: controller.scrollController,
                    children: [],
                  ),
                ))
              ],
            ),
          );
        });
  }
}
