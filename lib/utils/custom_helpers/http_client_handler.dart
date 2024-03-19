// ignore_for_file: library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getLib;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nassem/my_app/controller.dart';
import 'package:nassem/screens/auth/login/view.dart';
import '../../public_controllers/auth_controller.dart';
import '../constants/alerts.dart';
import '../translation/translation.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';

class HttpClient {
  HttpClient({
    this.baseUrl,
    this.isUploading,
  });
  String? baseUrl;
  static Future<HttpClient> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activate();
    String? url;
    url = "https://naseem-api.rowadtqnee.online/api";
    remoteConfig.getString("base_url");
    return HttpClient(
        baseUrl: url.isEmpty || url.contains("http") == false ? "" : url);
  }

  Connectivity con = Connectivity();
  static Map<String, dynamic>? getMyHeaders(
      {Map<String, dynamic>? otherHeaders}) {
    MyAppController mainApp = getLib.Get.find();
    AuthController auth = getLib.Get.find();
    Map<String, dynamic> h = {
      "lang": mainApp.lang == Lang.en ? "en" : "ar",
      "Authorization": auth.isAuthorized || auth.userModel?.token != null
          ? "Bearer ${auth.userModel?.token}"
          : null
    };
    for (String key in otherHeaders?.keys.toList() ?? {}) {
      h[key] = otherHeaders?[key];
    }
    return h;
  }

  bool? isUploading;

  Dio dioc = Dio();
  Dio get dio {
    Dio dioo = dioc
      ..interceptors.add(
        AwesomeDioInterceptor(
          logRequestTimeout: false,
          logRequestHeaders: true,
          logResponseHeaders: false,
          logger: debugPrint,
        ),
      );

    return dioo;
  }

  Future<Response?> postData({
    @required String? url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(int count, int total)? onSend,
    bool? dontShowMessage,
    bool? dontShowErrorMessage,
    bool? dontShowLoading,
    bool enableLog = false,
    String? fullUrl,
    @required Map<String, dynamic>? body,
    Function(Map<String, dynamic>? responseJson)? onSuccess,
    Function(Map<String, dynamic>? responseJson)? onError,
  }) async {
    // remove nulls from body
    body?.removeWhere(
      (key, value) => body[key] == null || body[key] == "",
    );

    try {
      ConnectivityResult result = await con.checkConnectivity();
      if (result == ConnectivityResult.none) {
        EasyLoading.showToast(
          "تحقق من إتصالك بالإنترنت!",
        );
      } else {
        if (queryParameters != null) {
          queryParameters.removeWhere(
            (key, value) =>
                queryParameters[key] == null || queryParameters[key] == "",
          );
        }
        if (dontShowLoading == null || dontShowLoading == false) {
          MyAppController.showLoading();
        }
        // if (enableLog) {
        //   dio = dio.interceptors.contains(DioInterceptor()) ? dio : dio
        //     ..interceptors.add(DioInterceptor());
        // } else {
        //   dio = dio..interceptors.removeWhere((e) => e == DioInterceptor());
        // }
        Response response = await dio.post(
          fullUrl == null
              ? "$baseUrl/$url"
              : fullUrl.replaceAll("http:", "https:"),
          onSendProgress: onSend,
          queryParameters: queryParameters,
          data: FormData.fromMap(body ?? {}),
          options: Options(
              headers: getMyHeaders(otherHeaders: headers),
              validateStatus: (status) {
                if (status == 401) {
                  GetStorage().erase();
                  AuthController auth = getLib.Get.find();
                  auth.isAuthorized = false;
                  auth.userModel = null;
                  auth.update();
                  getLib.Get.offAll(() => Login());
                }
                return true;
              }),
        );
        EasyLoading.dismiss();

        Map<String, dynamic>? responseJson;
        try {
          responseJson = response.data;
        } catch (_) {}
        if (response.statusCode == 401 || responseJson?['status'] == "401") {
          showCustomSnackBar(
            alertType: AlertType.fail,
            message:
                // responseJson?.message != null && responseJson?.message != ""
                //     ? responseJson?.message
                //     :
                "un_auth_msg".tr,
          );

          AuthController auth = getLib.Get.find();
          auth.logout();
        } else if (response.statusCode == 200 && onSuccess != null) {
          try {
            if ((dontShowMessage == null || dontShowMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.success,
                message: responseJson?['message'],
              );
            }
            onSuccess(responseJson);
          } catch (e) {
            // ignore: avoid_print
            print(e);
          }
        } else {
// on error
          if (responseJson?['status'].toString() != "200") {
            if ((dontShowErrorMessage == null ||
                    dontShowErrorMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.fail,
                message: responseJson?['message'],
              );
            }
            if (onError != null) {
              onError(responseJson);
            }
          }
        }
        return response;
      }
    } on DioError catch (err) {
      // ignore: avoid_print
      print(err);
      return null;
    }
    return null;
  }

// ------- UPDATE DATA TO SERVER -------//
  Future<Response?> updateData({
    @required String? url,
    Function(int count, int total)? onSend,
    Map<String, dynamic>? headers,
    bool? dontShowMessage,
    Map<String, dynamic>? queryParameters,
    @required Map<String, dynamic>? body,
    bool? dontShowLoading,
    bool enableLog = false,
    bool? dontShowErrorMessage,
    Function(Map<String, dynamic>? responseJson)? onSuccess,
    Function(Map<String, dynamic>? responseJson)? onError,
  }) async {
    // remove nulls from body
    body?.removeWhere(
      (key, value) => body[key] == null || body[key] == "",
    );

    try {
      ConnectivityResult result = await con.checkConnectivity();
      if (
          // checkInternet != null &&
          //   checkInternet &&
          result == ConnectivityResult.none) {
        EasyLoading.showToast(
          "تحقق من إتصالك بالإنترنت!",
        );
      } else {
        if (queryParameters != null) {
          queryParameters.removeWhere(
            (key, value) =>
                queryParameters[key] == null || queryParameters[key] == "",
          );
        }
        if (dontShowLoading == null || dontShowLoading == false) {
          MyAppController.showLoading();
        }
        // if (enableLog) {
        //   dio = dio.interceptors.contains(DioInterceptor()) ? dio : dio
        //     ..interceptors.add(DioInterceptor());
        // } else {
        //   dio = dio..interceptors.removeWhere((e) => e == DioInterceptor());
        // }
        Response response = await dio.put(
          "$baseUrl/$url",
          data: body,
          queryParameters: queryParameters,
          onSendProgress: onSend,
          options: Options(
              headers: getMyHeaders(otherHeaders: headers),
              validateStatus: (status) {
                if (status == 401) {
                  GetStorage().erase();
                  AuthController auth = getLib.Get.find();
                  auth.isAuthorized = false;
                  auth.userModel = null;
                  auth.update();
                  getLib.Get.offAll(() => Login());
                }
                return true;
              }),
        );
        if (dontShowLoading == null || dontShowLoading == false) {
          EasyLoading.dismiss();
        }
        Map<String, dynamic>? responseJson;
        try {
          responseJson = response.data;
        } catch (_) {}

        if (response.statusCode == 401 || responseJson?['status'] == "401") {
          showCustomSnackBar(
            alertType: AlertType.fail,
            message:
                // responseJson?.message != null && responseJson?.message != ""
                //     ? responseJson?.message
                //     :
                "un_auth_msg".tr,
          );

          AuthController auth = getLib.Get.find();
          auth.logout();
        } else if (response.statusCode == 200 && onSuccess != null) {
          try {
            if ((dontShowMessage == null || dontShowMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.success,
                message: responseJson?['message'],
              );
            }
            onSuccess(responseJson);
          } catch (e) {
            // ignore: avoid_print
            print(e);
          }
        } else {
// on error
          if (responseJson?['status'].toString() != "200") {
            if ((dontShowErrorMessage == null ||
                    dontShowErrorMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.fail,
                message: responseJson?['message'],
              );
            }
            if (onError != null) {
              onError(responseJson);
            }
          }
        }
        return response;
      }
    } on DioError catch (err) {
      // ignore: avoid_print
      print(err);
      return null;
    }
    return null;
  }

  // ------ GET DATA fromMap SERVER -------//
  Future<Response?> getData({
    @required String? url,
    String? fullUrl,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(int, int)? onRecieve,
    bool? dontShowMessage,
    bool? dontShowErrorMessage,
    bool? checkInternet,
    bool enableLog = false,
    bool? dontShowLoading,
    Function(Map<String, dynamic>? responseJson)? onSuccess,
    Function(Map<String, dynamic>? responseJson)? onError,
  }) async {
    try {
      Connectivity con = Connectivity();
      ConnectivityResult result = await con.checkConnectivity();
      if (
          // checkInternet != null &&
          //   checkInternet &&
          result == ConnectivityResult.none) {
        EasyLoading.showToast(
          "تحقق من إتصالك بالإنترنت!",
        );
      } else {
        if (queryParameters != null) {
          queryParameters.removeWhere(
            (key, value) =>
                queryParameters[key] == null || queryParameters[key] == "",
          );
        }
        if (dontShowLoading == null || dontShowLoading == false) {
          MyAppController.showLoading();
        }
        // if (enableLog) {
        //   dio = dio.interceptors.contains(DioInterceptor()) ? dio : dio
        //     ..interceptors.add(DioInterceptor());
        // } else {
        //   dio = dio..interceptors.removeWhere((e) => e == DioInterceptor());
        // }
        Response response = await dio.get(
          fullUrl == null
              ? "$baseUrl/$url"
              : fullUrl.replaceAll("http:", "https:"),
          queryParameters: queryParameters,
          onReceiveProgress: onRecieve,
          options: Options(
              headers: getMyHeaders(otherHeaders: headers),
              validateStatus: (status) {
                if (status == 401) {
                  GetStorage().erase();
                  AuthController auth = getLib.Get.find();
                  auth.isAuthorized = false;
                  auth.userModel = null;
                  auth.update();
                  getLib.Get.offAll(() => Login());
                }
                return true;
              }),
        );
        if (dontShowLoading == null || dontShowLoading == false) {
          EasyLoading.dismiss();
        }
        if (response.data.runtimeType == String) {
          return null;
        }
        Map<String, dynamic>? responseJson;
        try {
          responseJson = response.data;
        } catch (_) {}
        if (response.statusCode == 401 || responseJson?['status'] == "401") {
          showCustomSnackBar(
            alertType: AlertType.fail,
            message:
                // responseJson?.message != null && responseJson?.message != ""
                //     ? responseJson?.message
                //     :
                "un_auth_msg".tr,
          );

          AuthController auth = getLib.Get.find();
          auth.logout();
        } else if (response.statusCode == 200 && onSuccess != null) {
          try {
            if ((dontShowMessage == null || dontShowMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.success,
                message: responseJson?['message'],
              );
            }
            onSuccess(responseJson);
          } catch (e) {
            // ignore: avoid_print
            print(e);
          }
        } else {
// on error
          if (responseJson?['status'].toString() != "200") {
            if ((dontShowErrorMessage == null ||
                    dontShowErrorMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.fail,
                message: responseJson?['message'],
              );
            }
            if (onError != null) {
              onError(responseJson);
            }
          }
        }
        return response;
      }
    } on DioError catch (err) {
      // ignore: avoid_print
      print(err);
      return null;
    }
    return null;
  }

  Future<Response?> delete({
    @required String? url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool? dontShowMessage,
    bool? checkInternet,
    bool? dontShowErrorMessage,
    bool enableLog = false,
    bool? dontShowLoading,
    Map<String, dynamic>? body,
    Function(Map<String, dynamic>? responseJson)? onSuccess,
    Function(Map<String, dynamic>? responseJson)? onError,
  }) async {
    try {
      ConnectivityResult result = await con.checkConnectivity();
      if (result == ConnectivityResult.none) {
        EasyLoading.showToast(
          "تحقق من إتصالك بالإنترنت!",
        );
      } else {
        if (queryParameters != null) {
          queryParameters.removeWhere(
            (key, value) =>
                queryParameters[key] == null || queryParameters[key] == "",
          );
        }
        if (dontShowLoading == null || dontShowLoading == false) {
          MyAppController.showLoading();
        }
        // if (enableLog) {
        //   dio = dio.interceptors.contains(DioInterceptor()) ? dio : dio
        //     ..interceptors.add(DioInterceptor());
        // } else {
        //   dio = dio..interceptors.removeWhere((e) => e == DioInterceptor());
        // }
        Response response = await dio.delete(
          "$baseUrl/$url",
          queryParameters: queryParameters,
          options: Options(
              headers: getMyHeaders(otherHeaders: headers),
              validateStatus: (status) {
                if (status == 401) {
                  GetStorage().erase();
                  AuthController auth = getLib.Get.find();
                  auth.isAuthorized = false;
                  auth.userModel = null;
                  auth.update();
                  getLib.Get.offAll(() => Login());
                }
                return true;
              }),
        );
        if (dontShowLoading == null || dontShowLoading == false) {
          EasyLoading.dismiss();
        }
        Map<String, dynamic>? responseJson;
        try {
          responseJson = response.data;
        } catch (_) {}
        if (response.statusCode == 401 || responseJson?['status'] == "401") {
          showCustomSnackBar(
            alertType: AlertType.fail,
            message:
                // responseJson?.message != null && responseJson?.message != ""
                //     ? responseJson?.message
                //     :
                "un_auth_msg".tr,
          );

          AuthController auth = getLib.Get.find();
          auth.logout();
        } else if (response.statusCode == 200 && onSuccess != null) {
          try {
            if ((dontShowMessage == null || dontShowMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.success,
                message: responseJson?['message'],
              );
            }
            onSuccess(responseJson);
          } catch (e) {
            // ignore: avoid_print
            print(e);
          }
        } else {
// on error
          if (responseJson?['status'].toString() != "200") {
            if ((dontShowErrorMessage == null ||
                    dontShowErrorMessage == false) &&
                responseJson?['message'] != null &&
                responseJson?['message'] != "") {
              showCustomSnackBar(
                alertType: AlertType.fail,
                message: responseJson?['message'],
              );
            }
            if (onError != null) {
              onError(responseJson);
            }
          }
        }
        return response;
      }
    } on DioError catch (err) {
      // ignore: avoid_print
      print(err);
      return null;
    }
    return null;
  }
}
