import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/cart_helper.dart';
import 'package:ali_pasha_graph/models/cart_model.dart';
import 'package:ali_pasha_graph/models/pricing_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartItemLogic extends GetxController {
  Rxn<CartModel> cart = Rxn<CartModel>(Get.arguments);
  RxList<CartModel> carts = RxList<CartModel>([]);
  MainController mainController = Get.find<MainController>();
  RxDouble total = RxDouble(0);
  RxDouble totalWeight = RxDouble(0);
  RxDouble shipping = RxDouble(0);
  RxDouble totalShipping = RxDouble(0);
  RxBool loading = RxBool(false);
  TextEditingController addressController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
RxString address=RxString('');
RxString phone=RxString('');
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    address.value=mainController.authUser.value?.address??'';
    phone.value=mainController.authUser.value?.phone??'';
    addressController.value=TextEditingValue(text: mainController.authUser.value?.address??'');
    phoneController.value=TextEditingValue(text: mainController.authUser.value?.phone??'');
    mainController.pricing
        .sort((a, b) => int.tryParse("${(a.weight ?? 0) - (b.weight ?? 0)}") ?? 0);
  }

  @override
  onReady() {
    super.onReady();
    getCart();
  }

  getCart() async{
   var list=await CartHelper.getCart();
    carts(
       list.where(
            (el) => el.seller?.seller_name == cart.value?.seller?.seller_name)
        .toList());
    total.value = carts.length > 0
        ? carts.fold(0.0,
            (previousValue, element) {
            double elementPrice = element.product?.is_discount == true
                ? element.product?.discount ?? 0.0
                : element.product?.price ?? 0;
            int elementQty = element.qty ?? 0;
            return previousValue + (elementPrice * elementQty);
          })
        : 0.0;
// calc far By weight
    shipping.value = carts.length > 0
        ? carts.where((el) => el.product?.is_delivery == true).fold(0.0,
            (previousValue, element) {
            var weight = (element.product?.weight ?? 0) * element.qty!;
            return previousValue + weight;
          })
        : 0.0;

    calcShipping();
  }

  calcShipping() {

    PricingModel? pricing = mainController.pricing
        .firstWhereOrNull((el) => el.weight! >= shipping.value);
    CartModel firstCart = carts.first;
    if (pricing == null) {
    throw  Exception('الوزن أكبر من المسموح يرجى التواصل مع الإدارة');
    }

    var authCity = mainController.authUser.value?.city?.cityId != null
        ? mainController.authUser.value?.city?.cityId
        : mainController.authUser.value?.city?.id;
    var sellerCity = firstCart.seller?.city?.cityId != null
        ? firstCart.seller?.city?.cityId
        : firstCart.seller?.city?.id;
mainController.logger.f(mainController.pricing.first.toJson());
mainController.logger.f(pricing.toJson());
mainController.logger.f(authCity);
mainController.logger.f(sellerCity);
  var index= carts.indexWhere((el)=>el.product?.is_delivery==true);
  if(index >-1){
    if (authCity != null && sellerCity != null && authCity == sellerCity) {
      totalShipping.value = pricing.internal_price!;
    } else {
      totalShipping.value = pricing.external_price!;
    }
  }else{
    totalShipping.value = 0;
  }
  }

  createOrder() async {

    loading.value=true;

    // Map<String, dynamic> data = {};
    // data['seller_id'] = carts.first.seller?.id;
    // data['weight'] = shipping.value;
    // data['address'] = address.value;
    // data['phone'] = phone.value;
    // data['items'] = carts
    //     .map((el) =>
    //         {"product_id": "${el.product?.id}", 'qty': el.qty?.toDouble()})
    //     .toList();
    Map<String, dynamic> data = {
      'seller_id': carts.first.seller?.id,
      'weight': shipping.value,
      'address': address.value,
      'phone': phone.value,
      'items': carts
          .map((el) => {
        "product_id": "${el.product?.id}",
        'qty': el.qty?.toDouble()
      })
          .toList(),
    };
    mainController.logger.i(data);
    mainController.query.value = r'''
    mutation CreateInvoice($input:InvoiceInput!){
      createInvoice(input:$input){
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
    mainController.variables.value={'input': data};
    try {
      calcShipping();
      var res = await mainController.fetchData();
      mainController.logger.f(res?.data);
      if(res?.data?['data']?['createInvoice']!=null){
        mainController.showToast(text: 'الطلب بإنتظار المراجعة شكراً لك');
        for(var i in carts){
          mainController.deleteFromCart(
              product: i.product!);

        }
        await mainController
            .refreshCart();
        getCart();
      }else{
        throw Exception('خطأ في الطلب يرجى المحاولة لاحقاً');
      }

    } catch (e) {
      mainController.showToast(text: '$e'.replaceAll('Exception:', ''),type: 'error');
    }
    loading.value=false;
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
