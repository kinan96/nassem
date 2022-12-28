import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../my_app/controller.dart';

launchMobile(String mobile) async {
  if (await canLaunchUrlString("tel:$mobile")) {
    await launchUrlString("tel:$mobile");
  } else {
    EasyLoading.showToast("phone_error".tr,
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}

launchMyUrl(String url) async {
  MyAppController.showLoading();
  if (!url.contains("http")) {
    url = "https://$url";
  }
  Uri myUrl = Uri.parse(url);
  if (await launchUrl(myUrl)) {
    EasyLoading.dismiss();
    await launchUrl(myUrl);
  } else if (await canLaunchUrl(
      Uri.parse(url.replaceAll("http://", "https://")))) {
    EasyLoading.dismiss();

    await launchUrl(Uri.parse(url.replaceAll("http://", "https://")));
  } else if (await canLaunchUrl(Uri.parse(url.replaceAll("http://", "")))) {
    EasyLoading.dismiss();

    await launchUrl(Uri.parse(url.replaceAll("http://", "")));
  } else if (await canLaunchUrl(Uri.parse(url.replaceAll("https://", "")))) {
    EasyLoading.dismiss();

    await launchUrl(Uri.parse(url.replaceAll("https://", "")));
  } else if (await canLaunchUrl(Uri.parse("http://$url"))) {
    EasyLoading.dismiss();

    await launchUrl(Uri.parse("http://$url"));
  } else if (await canLaunchUrl(Uri.parse("https://$url"))) {
    EasyLoading.dismiss();

    await launchUrl(Uri.parse("https://$url"));
  } else {
    EasyLoading.dismiss();

    EasyLoading.showToast("link_error".tr,
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}

launchWhatsapp(String? mobile) async {
  MyAppController.showLoading();
  if (await canLaunchUrlString("whatsapp://send?phone=$mobile")) {
    EasyLoading.dismiss();

    await launchUrlString(
      "whatsapp://send?phone=$mobile",
    );
  } else if (await canLaunchUrlString(
      "whatsapp://send?phone=${mobile?.replaceAll("+", "")}")) {
    EasyLoading.dismiss();

    await launchUrlString(
      "whatsapp://send?phone=${mobile?.replaceAll("+", "")}",
    );
  } else if (await canLaunchUrlString("https://wa.me/$mobile")) {
    EasyLoading.dismiss();

    await launchUrlString(
      "https://wa.me/$mobile",
    );
  } else if (await canLaunchUrlString(
      "https://wa.me/${mobile?.replaceAll("+", "")}")) {
    EasyLoading.dismiss();

    await launchUrlString(
      "https://wa.me/${mobile?.replaceAll("+", "")}",
    );
  } else if (await canLaunchUrlString(
      "https://api.whatsapp.com/send?phone=$mobile&text=السلام عليكم ورحمة الله وبركاته")) {
    EasyLoading.dismiss();

    await launchUrlString(
        "https://api.whatsapp.com/send?phone=$mobile&text=السلام عليكم ورحمة الله وبركاته");
  } else if (await canLaunchUrlString(
      "https://api.whatsapp.com/send?phone=${mobile?.replaceAll("+", "")}&text=السلام عليكم ورحمة الله وبركاته")) {
    EasyLoading.dismiss();

    await launchUrlString(
        "https://api.whatsapp.com/send?phone=${mobile?.replaceAll("+", "")}&text=السلام عليكم ورحمة الله وبركاته");
  } else {
    EasyLoading.dismiss();

    EasyLoading.showToast("whatsapp_error".tr,
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}
