import 'package:get/get.dart';
import 'package:nassem/main.dart';

class AboutController extends GetxController {
  String? data;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    httpClient.getData(
      url: "delivery/about",
      dontShowLoading: true,
      onSuccess: (responseJson) {
        data = responseJson?['data'];
        update();
      },
    );
  }
}
