import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/cart_model.dart';
import 'package:get/get.dart';

class CartItemLogic extends GetxController {
  Rxn<CartModel> cart = Rxn<CartModel>(Get.arguments);
  RxList<CartModel> carts = RxList<CartModel>([]);
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    getCart();
  }

  getCart() {
    carts.value = mainController.carts
        .where((el) => el.seller?.seller_name == cart.value?.seller?.seller_name).toList();
  }
}
