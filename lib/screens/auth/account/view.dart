import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/public_controllers/auth_controller.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';

class Account extends StatelessWidget {
  Account({super.key});
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return CustomAppScreen(
            appBar: customAppBar(context, title: "personal_account".tr),
          );
        });
  }
}
