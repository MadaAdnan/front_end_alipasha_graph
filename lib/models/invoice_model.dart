import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

class InvoiceModel {
  int? id;
  String? status;
  UserModel? user;
  UserModel? seller;
  String? created_at;
  String? address;
  String? phone;
  double? total;
  double? shipping;
  List<ItemInvoice>? items;

  InvoiceModel({
    this.id,
    this.seller,
    this.shipping,
    this.total,
    this.user,
    this.created_at,
    this.items,
    this.status,
    this.phone,
    this.address,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> data) {
    List<ItemInvoice> itemsList = [];
    if (data['items'] != null) {
      for (var i in data['items']) {
        itemsList.add(ItemInvoice.fromJson(i));
      }
    }
    return InvoiceModel(
        id: int.tryParse("${data['id']}"),
        total: double.tryParse("${data['total']}") ?? 0,
        shipping: double.tryParse("${data['shipping']}") ?? 0,
        created_at: "${data['created_at'] ?? ''}",
        status: "${data['status'] ?? ''}",
        address: "${data['address'] ?? ''}",
        phone: "${data['phone'] ?? ''}",
        user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
        seller:
            data['seller'] != null ? UserModel.fromJson(data['seller']) : null,
        items: itemsList);
  }
}

class ItemInvoice {
  ProductModel? product;
  String? qty;
  String? price;
  String? total;

  ItemInvoice({this.total, this.product, this.qty, this.price});

  factory ItemInvoice.fromJson(Map<String, dynamic> data) {
    return ItemInvoice(
        price: "${data['price'] ?? 0}",
        qty: "${data['qty'] ?? 1}",
        total: "${data['total'] ?? 0}",
        product: data['product'] != null
            ? ProductModel.fromJson(data['product'])
            : null);
  }
}
