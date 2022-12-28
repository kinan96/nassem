import 'package:ansi_logger/ansi_logger.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../public_models/user_model.dart';
import '../screens/auth/login/view.dart';

class AuthController extends GetxController {
  UserModel? userModel;
  bool isAuthorized = false;

  initAuth() async {
    bool authorized = await checkIsUserAuthorized();
    await Future.delayed(const Duration(seconds: 1));
    if (authorized) {
      // Get.offAll(const HomeScreen());
    }

    getInitialMessage();
  }

  getInitialMessage() async {
    RemoteMessage? remoteMessage = await FCMConfig.instance.getInitialMessage();
    if (remoteMessage != null) {
      // AllNotificationsController.onClickFCMNotification(remoteMessage);
    }
  }

  Future<bool> checkIsUserAuthorized() async {
    Map<String, dynamic>? user = GetStorage().read("user");

    if (user == null) {
      isAuthorized = false;
      update();
      return false;
    } else {
      userModel = UserModel.fromJson(user);

      AnsiLogger().logString(userModel?.token ?? "");

      isAuthorized = userModel?.token != null;
      update();
      return userModel?.token != null;
    }
  }

  login({String? email, String? password, bool splash = false}) async {
    // await httpClient.postData(
    //     url: "Account/login",
    //     dontShowMessage: true,
    //     body: {"email": email, "password": password},
    //     onSuccess: (json) {
    //       isAuthorized = true;
    //       userModel = UserModel.fromJson(
    //         json ?? {},
    //       );
    //       GetStorage().write("user", userModel?.toJson());
    //       update();
    //       // Get.offAll(const HomeScreen());
    //     });
  }

  void logout() async {
    userModel = null;
    isAuthorized = false;
    GetStorage().remove("user");
    update();
    Get.offAll(() => Login());
  }
}
