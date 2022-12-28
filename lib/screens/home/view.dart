import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/screens/all_orders/view.dart';
import 'package:nassem/screens/home/controller.dart';
import 'package:nassem/screens/menu/view.dart';
import 'package:nassem/screens/wallet/view.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return CustomAppScreen(
            body: PageView(
              controller: controller.pageController,
              onPageChanged: controller.selectTabOfIndex,
              children: const [AllOrders(), Wallet(), MenuScreen()],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                onTap: controller.selectTabOfIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: CustomImage(
                        svgAsset: "assets/images/home.svg",
                        color: controller.currentIndex == 0
                            ? AppColors.primary
                            : AppColors.blackGrey,
                      ),
                      label: "main".tr),
                  BottomNavigationBarItem(
                      icon: CustomImage(
                        svgAsset: "assets/images/wallet-3.svg",
                        color: controller.currentIndex == 1
                            ? AppColors.primary
                            : AppColors.blackGrey,
                      ),
                      label: "wallet".tr),
                  BottomNavigationBarItem(
                      icon: CustomImage(
                        svgAsset: "assets/images/menu.svg",
                        color: controller.currentIndex == 2
                            ? AppColors.primary
                            : AppColors.blackGrey,
                      ),
                      label: "menu".tr)
                ]),
          );
        });
  }
}
