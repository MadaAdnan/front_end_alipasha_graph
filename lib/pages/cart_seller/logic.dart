import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';

class CartSellerLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxList<CartModel> uniqueCartsList = RxList([]);

  @override
  onInit() {
    super.onInit();
    getSellers();
  }

  getSellers() {
    Map<int, CartModel> uniqueCartsMap = {};

    for (var cart in mainController.carts) {
      int? sellerId = cart.seller?.id;
      if (sellerId != null && !uniqueCartsMap.containsKey(sellerId)) {
        uniqueCartsMap[sellerId] = cart;
      }
    }

    uniqueCartsList(uniqueCartsMap.values.toList());
  }
}
