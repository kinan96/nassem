import 'package:get/get.dart';
import 'package:nassem/main.dart';
import 'package:nassem/screens/wallet/model.dart';

class WalletController extends GetxController {
  int walletStatusId = WalletStatusId.indebtedness;
  WalletModel? walletModel;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    walletModel = null;
    update();
    httpClient.getData(
      url: "delivery/${WalletStatusId.name(walletStatusId)}",
      dontShowLoading: true,
      dontShowMessage: true,
      onSuccess: (responseJson) {
        walletModel = WalletModel.fromJson(responseJson?['data']);
        update();
      },
    );
  }
}
