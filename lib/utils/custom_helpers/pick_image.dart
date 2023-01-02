import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
import '../custom_widgets/custom_button.dart';

Future<XFile?> pickImage({bool onlyGallery = false}) async {
  final ImagePicker imagePicker = ImagePicker();
  if (onlyGallery) {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return image;
  } else {
    XFile? imageXFile = await Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 0),
        titlePadding: const EdgeInsets.only(top: 15),
        content: Row(
          children: [
            Expanded(
                child: CustomButton(
              buttonType: ButtonType.icon,
              onPressed: () async {
                XFile? image = await imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                    preferredCameraDevice: CameraDevice.front);
                Get.back(result: image);
                return image;
              },
              iconData: Icons.camera_alt,
              iconColor: AppColors.primary,
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: CustomButton(
              buttonType: ButtonType.icon,
              onPressed: () async {
                XFile? image = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                );
                Get.back(result: image);
                return image;
              },
              iconData: Icons.image,
              iconColor: AppColors.primary,
            ))
          ],
        ));
    return imageXFile;
  }
}
