import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class CustomAppScreen extends StatelessWidget {
  final Function()? onWillPop;
  final Function()? onTapScreen;
  final EdgeInsets? padding;
  final Alignment stackAlignment;
  final List<Widget> behindBody;
  final List<Widget> aboveBody;
  final Color bgColor;
  final Widget? body;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? bottomNavigationBar;
  final Clip clip;
  const CustomAppScreen(
      {Key? key,
      this.clip = Clip.none,
      this.bottomNavigationBar,
      this.stackAlignment = Alignment.center,
      this.bgColor = AppColors.background,
      this.aboveBody = const [],
      this.floatingActionButtonLocation,
      this.behindBody = const [],
      this.floatingActionButton,
      this.scaffoldKey,
      this.body,
      this.appBar,
      this.padding,
      this.onTapScreen,
      this.onWillPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          EasyLoading.dismiss();
          if (onWillPop == null) {
            Get.back();
          } else {
            onWillPop?.call();
          }

          return Future.value(false);
        },
        child: GestureDetector(
            onTap: () {
              if (onTapScreen != null) {
                onTapScreen?.call();
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            child: Stack(
              children: [
                Scaffold(
                  key: scaffoldKey,
                  bottomNavigationBar: bottomNavigationBar,
                  backgroundColor: bgColor,
                  appBar: appBar,
                  floatingActionButton: floatingActionButton,
                  floatingActionButtonLocation: floatingActionButtonLocation,
                  body: Stack(
                    clipBehavior: Clip.none,
                    alignment: stackAlignment,
                    children: [
                      ...behindBody,
                      Container(
                        width: Get.width,
                        height: Get.height,
                        padding: padding ??
                            const EdgeInsets.symmetric(horizontal: 10),
                        child: body ?? Container(),
                      ),
                      ...aboveBody,
                    ],
                  ),
                ),
              ],
            )));
  }
}
