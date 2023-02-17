import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nassem/my_app/controller.dart';
import 'package:nassem/screens/auth/confirmation/view.dart';
import 'package:nassem/screens/auth/new_password/view.dart';
import 'package:nassem/screens/home/view.dart';
import '../main.dart';
import '../public_models/user_model.dart';
import '../screens/auth/login/view.dart';

class AuthController extends GetxController {
  UserModel? userModel;
  bool isAuthorized = false;

  initAuth() async {
    bool authorized = await checkIsUserAuthorized();
    await Future.delayed(const Duration(seconds: 1));
    if (authorized) {
      Get.offAll(const HomeScreen());
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

      isAuthorized = userModel?.token != null;
      update();
      return userModel?.token != null;
    }
  }

  login({String? email, String? password, bool splash = false}) async {
    MyAppController myAppController = Get.find();
    await httpClient.postData(
        url: "delivery/auth/login",
        dontShowMessage: true,
        body: {
          "email": email,
          "password": password,
          "type": myAppController.deviceType,
          "fcm_token": myAppController.deviceToken,
          "device_id": myAppController.deviceToken
        },
        onSuccess: (json) {
          isAuthorized = true;
          userModel = UserModel.fromJson(json?['data']);
          GetStorage().write("user", userModel?.toJson());
          update();
          Get.offAll(const HomeScreen());
        });
  }

  void logout() async {
    httpClient.postData(
      url: "delivery/auth/logout",
      body: {},
      onSuccess: (responseJson) {
        userModel = null;
        isAuthorized = false;
        GetStorage().remove("user");
        update();
        Get.offAll(() => Login());
      },
    );
  }

  forgetPassword(String email) async {
    httpClient.postData(
      url: "delivery/auth/forget-password",
      body: {"email": email},
      onSuccess: (responseJson) {
        userModel = UserModel(email: email);
        isAuthorized = false;
        update();
        Get.to(() => Confirmation());
      },
    );
  }

  resendForgetPassword() async {
    httpClient.postData(
      url: "delivery/auth/forget-password",
      body: {"email": userModel?.email},
      onSuccess: (responseJson) {},
    );
  }

  activeCode(String? code) async {
    httpClient.postData(
      url: "delivery/auth/check-code",
      body: {"email": userModel?.email, "code": code},
      onSuccess: (responseJson) {
        Get.to(NewPassword());
      },
    );
  }

  setNewPassword(String? newPass) async {
    httpClient.postData(
      url: "delivery/auth/reset-password",
      body: {"email": userModel?.email, "password": newPass},
      onSuccess: (responseJson) {
        login(email: userModel?.email, password: newPass);
      },
    );
  }
}
