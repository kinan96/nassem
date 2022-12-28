import 'package:get/get.dart';
import 'package:nassem/my_app/controller.dart';

import 'auth_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MyAppController>(MyAppController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
