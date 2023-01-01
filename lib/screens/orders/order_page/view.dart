import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nassem/screens/orders/model.dart';
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
  const OrderPage({super.key, this.orderTypeId = OrderTypeId.delivering});

  @override
  Widget build(BuildContext context) {
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
                4,
                (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ProductList(),
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
                text: "payment_upon_receipt".tr,
              )),
              const CustomTextWithIconRow(
                svgImageAsset: "assets/images/profile-circle.svg",
                text: "مصطفى باشا القديم",
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
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.greyContainer,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomText(
                    "العميل لم يرد علي اتصالاتنا ولم يكن متواجد في المنزل",
                    color: AppColors.grey,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: Get.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      4,
                      (index) => CustomImage(
                        urlImage:
                            "https://i.picsum.photos/id/297/536/354.jpg?hmac=FUNXwbNpJpjLHIDJ5skSQWj4ETqgiWEWx6pSGYCNyp4",
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
            "القاهرة - عين شمس",
            fontSize: 16,
          ),
          CustomText(
            "١٤ شارع النزهة - بجوار الحديقة الدولية",
            color: AppColors.grey,
          ),
          RichText(
            text: TextSpan(
                text: "${"phone_number".tr} :",
                style: TextStyle(
                    fontFamily: appFontFamily, color: AppColors.black),
                children: [
                  TextSpan(
                      text: "    01010690468",
                      style: TextStyle(color: AppColors.grey))
                ]),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomMap(
                width: Get.width,
                height: 150,
                mapAddressCoord: const LatLng(89, 10.11),
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
                      mapAddressCoord: const LatLng(89, 10.11),
                    ));
                  },
                  text: "address_change".tr,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
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
              _orderPriceRow("the_total".tr, 100),
              _orderPriceRow("delivery_charge".tr, 40),
              _orderPriceRow("${"tax".tr} (15%)", 20),
              _orderPriceRow("total".tr, 160),
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
                  child: const OrderActionsRow())
            ],
    );
  }

  TableRow _orderPriceRow(String title, double price) {
    return TableRow(
      children: [
        CustomText(
          title,
          color: AppColors.grey,
        ),
        CustomText(
          "${price.toStringAsFixed(2)} ${"riyal".tr}",
          color: AppColors.black,
        )
      ],
    );
  }
}
