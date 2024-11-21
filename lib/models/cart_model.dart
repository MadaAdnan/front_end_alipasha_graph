import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

class CartModel {
 ProductModel? product;


  int? qty;
  UserModel? seller;

  CartModel(
      {this.product,
      this.seller,
      this.qty = 0,});

  CartModel.fromJson(Map<String, dynamic> data) {
    product = data['product']!=null ?ProductModel.fromJson(data['product']) :null;

    qty = data['qty'] ?? 1;
    seller = UserModel.fromJson(data['seller'] ?? data['user']);
  }


  addQty() {
    if (qty == null) {
      qty = 1;
    } else {
      qty = qty! + 1;
    }
  }

  minQty() {
    if (qty! > 1) {
      qty = qty! - 1;
    }
  }

  toJson() {
    Map<String, dynamic> data = {
      "product": product?.toJson(),
      "qty": qty,
      "seller": {
        "id": "${seller?.id}",
        "seller_name": "${seller?.seller_name}",
        "logo": "${seller?.logo}",
      }
    };
    return data;
  }
}
