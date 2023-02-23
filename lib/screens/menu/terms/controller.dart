import 'package:get/get.dart';
import 'package:nassem/main.dart';

class TermsController extends GetxController {
  String? data;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    httpClient.getData(
      url: "delivery/terms",
      dontShowLoading: true,
      onSuccess: (responseJson) {
        data = responseJson?['data'];
        update();
      },
    );
  }
}
