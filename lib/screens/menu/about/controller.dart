import 'package:get/get.dart';
import 'package:nassem/main.dart';

class AboutController extends GetxController {
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    httpClient.getData(
      url: "delivery/about",
      onSuccess: (responseJson) {},
    );
  }
}
