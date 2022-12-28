import 'package:get/get.dart';

class SplashController extends GetxController {
  bool showLogo = false;
  bool showLangs = false;
  show() async {
    Future.delayed(const Duration(milliseconds: 1)).then((value) {
      showLogo = true;
      update();
    });
    Future.delayed(const Duration(seconds: 1)).then((value) {
      showLangs = true;
      update();
    });
  }

  @override
  void onInit() {
    show();
    super.onInit();
  }
}
