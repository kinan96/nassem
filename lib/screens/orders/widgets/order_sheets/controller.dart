import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nassem/main.dart';
import 'package:nassem/screens/orders/all_orders/controller.dart';
import 'package:nassem/screens/orders/model.dart';
import 'package:nassem/utils/constants/alerts.dart';
import 'package:nassem/utils/custom_helpers/pick_image.dart';
import '../../../../utils/constants/bottom_sheet.dart';
import '../success_order_action_sheet.dart';

class OrderSheetsController extends GetxController {
  OrderSheetsController({this.orderTypeId, this.orderModel});
  final int? orderTypeId;
  final OrderModel? orderModel;
  final TextEditingController reasonCTL = TextEditingController();
  int get allFilesLength => imagesPaths.length + filesPaths.length;
  List<String> imagesPaths = [];
  List<String> filesPaths = [];
  pickImageFile() async {
    pickImage().then((value) {
      if (value != null) {
        imagesPaths.add(value.path);
        update();
      }
    });
  }

  pickFiles() async {
    FilePicker.platform
        .pickFiles(
      allowCompression: true,
      allowMultiple: true,
    )
        .then((value) {
      if (value?.files.isNotEmpty == true) {
        filesPaths
            .addAll(value?.files.map((e) => e.path.toString()).toList() ?? []);
        update();
      }
    });
  }

  sendDeliveredOrder() {
    Get.back();

    httpClient.postData(
      url: "delivery/delivery-order/${orderModel?.id}",
      body: {},
      onSuccess: (responseJson) {
        AllOrdersController allOrdersController = Get.find();
        allOrdersController.getOrders();
      },
    );
  }

  sendFaltOrder(GlobalKey<FormState> form) async {
    if (form.currentState?.validate() == false) {
      return;
    }
    if (imagesPaths.isEmpty) {
      showCustomSnackBar(
          alertType: AlertType.warning, message: "add_image_first".tr);
      return;
    }
    List<dio.MultipartFile> images = [];
    for (String path in imagesPaths) {
      final mpfImage = await dio.MultipartFile.fromFile(path);
      images.add(mpfImage);
    }
    httpClient.postData(
      dontShowMessage: true,
      url: "delivery/miss-delivery-order/${orderModel?.id}",
      body: {"reason": reasonCTL.text, "images[]": images},
      onSuccess: (responseJson) {
        Get.back();
        AllOrdersController allOrdersController = Get.find();
        allOrdersController.getOrders();
        showCustomBottomSheet(child: const SuccessOrderActionSheet());
      },
    );
  }
}
