import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/screens/orders/order_page/controller.dart';
import 'package:nassem/screens/orders/widgets/order_actions.dart';
import 'package:nassem/screens/orders/widgets/product_list.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/constants/styles_and_themes.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_map/view.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:nassem/utils/custom_widgets/text_with_icon.dart';

import '../../../utils/custom_widgets/custom_button.dart';

class OrderPage extends StatelessWidget {
  final int orderTypeId;
  final OrderModel? orderModel;
  const OrderPage(
      {super.key, this.orderModel, this.orderTypeId = OrderTypeId.delivering});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: OrderController(orderModel!),
        builder: (controller) {
          return CustomAppScreen(
            appBar: customAppBar(context, title: "order_details".tr),
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomTextWithIconRow(
                  text: "products".tr,
                  textColor: AppColors.grey,
                  svgImageAsset: "assets/images/box.svg",
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(
                      controller.orderModel.orderDetails?.length ?? 0,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ProductList(
                              orderDetail:
                                  controller.orderModel.orderDetails?[index],
                            ),
                          )),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextWithIconRow(
                      expandedText: true,
                      svgImageAsset: "assets/images/wallet-money.svg",
                      text: getPaymentMethodName(
                          controller.orderModel.paymentMethod),
                    )),
                    CustomTextWithIconRow(
                      svgImageAsset: "assets/images/profile-circle.svg",
                      text: controller.orderModel.receiverName ?? "",
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Offstage(
                  offstage: orderTypeId != OrderTypeId.stalled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText("cause_of_stumbling".tr),
                      Offstage(
                        offstage: controller.orderModel.cancelReason == null ||
                            controller.orderModel.cancelReason?.isEmpty == true,
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColors.greyContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomText(
                            controller.orderModel.cancelReason ?? "",
                            color: AppColors.grey,
                            fontSize: 12,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            controller.orderModel.attaches?.length ?? 0,
                            (index) => CustomImage(
                              urlImage: controller.orderModel.attaches?[index],
                              padding: const EdgeInsets.all(2.5),
                              width: 50,
                              height: 50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
                CustomTextWithIconRow(
                  text: "the_address".tr,
                  svgImageAsset: "assets/images/receipt.svg",
                  iconColor: AppColors.grey,
                  textColor: AppColors.grey,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  controller.orderModel.address ?? "",
                  fontSize: 16,
                ),
                RichText(
                  text: TextSpan(
                      text: "${"phone_number".tr} :",
                      style: const TextStyle(
                          fontFamily: appFontFamily, color: AppColors.black),
                      children: [
                        TextSpan(
                            text:
                                "    ${Get.locale?.languageCode == "ar" ? (controller.orderModel.receiverPhone?.replaceAll("+", "")) : (controller.orderModel.receiverPhone ?? "")}",
                            children: Get.locale?.languageCode == "ar" &&
                                    controller.orderModel.receiverPhone
                                            ?.contains("+") ==
                                        true
                                ? [const TextSpan(text: "+")]
                                : null,
                            style: const TextStyle(color: AppColors.grey))
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Offstage(
                  offstage: controller.orderModel.lat == null,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomMap(
                        width: Get.width,
                        height: 150,
                        mapAddressCoord: LatLng(controller.orderModel.lat ?? 0,
                            controller.orderModel.lng ?? 0),
                        borderRadius: BorderRadius.circular(10),
                        onlyShow: true,
                      ),
                      SizedBox(
                        width: Get.width / 3,
                        child: CustomButton(
                          buttonType: ButtonType.text,
                          bgColor: AppColors.primaryWithOpacity,
                          textColor: AppColors.primary,
                          onPressed: () {
                            Get.to(CustomMap(
                              mapAddressCoord: LatLng(
                                  controller.orderModel.lat ?? 0,
                                  controller.orderModel.lng ?? 0),
                            ));
                          },
                          text: "address_change".tr,
                        ),
                      )
                    ],
                  ),
                ),
                Offstage(
                  offstage: controller.orderModel.lat == null,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                ),
                CustomTextWithIconRow(
                  text: "order_summary".tr,
                  svgImageAsset: "assets/images/receipt.svg",
                  iconColor: AppColors.grey,
                  textColor: AppColors.grey,
                ),
                const SizedBox(
                  height: 5,
                ),
                Table(
                  children: [
                    _orderPriceRow(
                        "the_total".tr, controller.orderModel.subTotal ?? ""),
                    _orderPriceRow("delivery_charge".tr,
                        controller.orderModel.deliveryFees ?? ""),
                    _orderPriceRow(
                        "${"tax".tr} (${(((double.tryParse(controller.orderModel.tax ?? "") ?? 0) / (double.tryParse(controller.orderModel.subTotal ?? "") ?? 1)) * 100).toStringAsFixed(0)}%)",
                        controller.orderModel.tax ?? ""),
                    _orderPriceRow(
                        "total".tr, controller.orderModel.total ?? ""),
                    if (orderTypeId == OrderTypeId.delivered)
                      _orderPriceRow(
                          "delivered".tr,
                          controller.orderModel.deliveryDate == null
                              ? ""
                              : intl.DateFormat.Hm().format(
                                  controller.orderModel.deliveryDate ??
                                      DateTime.now()),
                          isNotPrice: true)
                  ],
                ),
                SizedBox(
                  height: orderTypeId != OrderTypeId.delivering ? 20 : 80,
                )
              ],
            )),
            stackAlignment: Alignment.bottomCenter,
            aboveBody: orderTypeId != OrderTypeId.delivering
                ? []
                : [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.unSelectedGreyContainer,
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                spreadRadius: 1)
                          ],
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          color: AppColors.white,
                        ),
                        child: OrderActionsRow(
                          orderModel: orderModel,
                        ))
                  ],
          );
        });
  }

  TableRow _orderPriceRow(String title, String value, {bool? isNotPrice}) {
    return TableRow(
      children: [
        CustomText(
          title,
          color: AppColors.grey,
        ),
        CustomText(
          "$value ${isNotPrice == true ? "" : "riyal".tr}",
          color: AppColors.black,
        )
      ],
    );
  }
}
