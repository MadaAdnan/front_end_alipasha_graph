import 'package:ali_pasha_graph/models/user_model.dart';

class CartModel {
  int? productId;
  String? productName;
  String? productImage;
  int? qty;
  double? price;
  UserModel? seller;

  CartModel(
      {this.productId,
      this.price,
      this.seller,
      this.qty = 0,
      this.productName,
      this.productImage});

  CartModel.fromJson(Map<String, dynamic> data) {
    productId = data['productId'] ?? data['id'];
    productName = data['productName'] ?? data['name'];
    productImage = data['productImage'] ?? data['image'];
    qty = data['qty'] ?? 1;
    price = data['price'];
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
      "id": productId,
      "name": productName,
      "qty": qty,
      "price": price,
      "image": productImage,
      "seller": {
        "id": "${seller?.id}",
        "seller_name": "${seller?.seller_name}",
        "logo": "${seller?.logo}",
      }
    };
    return data;
  }
}
