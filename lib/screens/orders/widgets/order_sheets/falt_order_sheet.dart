import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/screens/orders/widgets/order_sheets/controller.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_helpers/validators.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_button.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';
import 'package:nassem/utils/custom_widgets/custom_text_form_field.dart';

class FaltOrderSheet extends StatelessWidget {
  final OrderModel? orderModel;
  FaltOrderSheet({super.key, required this.orderModel});
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderSheetsController>(
        init: OrderSheetsController(
            orderTypeId: OrderTypeId.stalled, orderModel: orderModel),
        builder: (controller) {
          return Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CustomTextFormField(
                    label: "cause_of_stumbling".tr,
                    cancelLabel: true,
                    maxLines: 5,
                    minLines: 5,
                    controller: controller.reasonCTL,
                    validator: emptyValidate,
                    keyboardType: TextInputType.multiline,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryWithOpacity),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(child: CustomText("attach_file".tr)),
                        // IconButton(
                        //     padding: EdgeInsets.zero,
                        //     onPressed: () => controller.pickFiles(),
                        //     icon: const CustomImage(
                        //       svgAsset: "assets/images/document-upload.svg",
                        //     )),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => controller.pickImageFile(),
                            icon: const CustomImage(
                              svgAsset: "assets/images/camera.svg",
                            ))
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: controller.allFilesLength == 0,
                    child: Container(
                      width: Get.width,
                      height: 90,
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...List.generate(
                              controller.imagesPaths.length,
                              (index) => CustomImage(
                                    width: 70,
                                    height: 90,
                                    borderRadius: BorderRadius.circular(10),
                                    padding: const EdgeInsets.all(2.5),
                                    fit: BoxFit.cover,
                                    fileImage:
                                        File(controller.imagesPaths[index]),
                                  )),
                          ...List.generate(
                              controller.filesPaths.length,
                              (index) => Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 90,
                                    margin: const EdgeInsets.all(2.5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryWithOpacity),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(2.5),
                                    child: CustomText(
                                      controller.filesPaths[index]
                                          .split("/")
                                          .last,
                                      textAlign: TextAlign.center,
                                      autoSized: true,
                                      maxLines: 1,
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonType: ButtonType.text,
                    onPressed: () {
                      controller.sendFaltOrder(form);
                    },
                    text: "send".tr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
