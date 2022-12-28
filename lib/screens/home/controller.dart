import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  PageController pageController = PageController();
  selectTabOfIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    update();
  }
}
