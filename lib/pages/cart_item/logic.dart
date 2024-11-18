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
        .where(
            (el) => el.seller?.seller_name == cart.value?.seller?.seller_name)
        .toList();
  }

  createOrder() async {
    mainController.logger.i(carts.map((el)=>cart.toJson()));
    Map<String, dynamic> data = {};
    data['seller_id'] = carts.first.seller?.id;
    data['weight'] = 23.toDouble();
    data['items'] =
        carts.map((el) => {"product_id":"${ el.product?.id}", 'qty': el.qty?.toDouble()}).toList();

    mainController.query.value = '''
    mutation CreateInvoice{
      createInvoice(input:$data){
          id
          user{
            name
          }
          seller{
            seller_name
          }
      }
    
    }
     ''';
    try{
      var res=await mainController.fetchData();
      mainController.logger.w(res?.data);
    }catch(e){
      mainController.logger.e(e);
    }
  }

  calcWithAi(String msg) async {
    //createOrder();
    mainController.logger.e(msg);
    String url = "http://85.215.154.88:5000/calculate-weight";
    try {
      var res = await GetConnect().post(url, {'input_text': msg});
      mainController.logger.w(res.body);
    } catch (e) {
      mainController.logger.d(e);
    }
  }
}
