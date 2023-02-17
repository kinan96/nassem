import 'package:get/get.dart';
import 'package:nassem/main.dart';
import 'package:nassem/screens/orders/model.dart';

class OrderController extends GetxController {
  OrderModel orderModel;
  OrderController(this.orderModel);
  getDetails() {
    httpClient.getData(
      url: "delivery/order/details/${orderModel.id}",
      dontShowMessage: true,
      dontShowLoading: true,
      onSuccess: (responseJson) {
        orderModel = OrderModel.fromJson(responseJson?['data']);
        update();
      },
    );
  }

  @override
  void onInit() {
    getDetails();
    super.onInit();
  }
}
