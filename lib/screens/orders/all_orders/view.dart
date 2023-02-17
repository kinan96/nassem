import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/public_controllers/auth_controller.dart';
import 'package:nassem/screens/notifications/notification_icon/notification_icon.dart';
import 'package:nassem/screens/orders/all_orders/controller.dart';
import 'package:nassem/screens/orders/widgets/order_card.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_empty_widget.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:nassem/utils/shimmers/custom_shimmer_builder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../utils/constants/colors.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, initialIndex: 0, length: 3);
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
                        GetBuilder<AuthController>(
                            init: AuthController(),
                            builder: (auth) {
                              return CustomText(
                                auth.userModel?.name ?? "",
                                color: AppColors.primary,
                              );
                            })
                      ],
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    const NotificationIcon(),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      buttonType: ButtonType.icon,
                      iconColor: AppColors.primary,
                      onPressed: () {
                        controller.searchWithBarcode();
                      },
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
                      onTap: (value) {
                        controller.orderTypeIndex = value;
                        controller.update();
                        controller.getOrders();
                      },
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
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  scrollController: controller.scrollController,
                  onRefresh: () {
                    controller.getOrders();
                  },
                  onLoading: () {
                    if (controller.allOrdersModel?.paginate?.nextPageUrl !=
                            null &&
                        controller.allOrdersModel?.paginate?.nextPageUrl !=
                            "") {
                      controller.getOrders(
                          next:
                              controller.allOrdersModel?.paginate?.nextPageUrl);
                    }
                  },
                  child: ListView(
                    controller: controller.scrollController,
                    children: controller.orders?.isEmpty == true
                        ? const [CustomEmptyWidget()]
                        : List.generate(
                            controller.orders?.length ?? 5,
                            (index) => controller.orders == null
                                ? CustomShimmerBuilder(
                                    child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: OrderCard(
                                      orderTypeId: controller.orderTypeIndex,
                                    ),
                                  ))
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: OrderCard(
                                      orderTypeId: controller.orderTypeIndex,
                                      orderModel: controller.orders?[index],
                                    ),
                                  )),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
