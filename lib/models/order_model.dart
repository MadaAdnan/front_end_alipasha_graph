import 'package:ali_pasha_graph/models/user_model.dart';

class OrderModel {
  int? id;
  double? size;
  double? weight;
  double? height;
  double? width;
  double? length;
  double? price;
  String? receive_name;
  String? receive_address;
  String? receive_phone;
  String? sender_name;
  String? sender_phone;
  String? status;

  String? created_at;
  UserModel? from;
  UserModel? to;

  OrderModel(
      {this.id,
      this.length,
      this.to,
      this.width,
      this.price,
      this.created_at,
      this.height,
      this.size,
      this.weight,
      this.from,
      this.receive_address,
      this.receive_name,
      this.receive_phone,
      this.sender_name,
      this.sender_phone,
      this.status});

  factory OrderModel.fromJson(Map<String, dynamic> data) {
    return OrderModel(
      id: int.tryParse("${data['id']}"),
      size: double.tryParse("${data['size']}"),
      weight: double.tryParse("${data['weight']}"),
      height: double.tryParse("${data['height']}"),
      width: double.tryParse("${data['width']}"),
      length: double.tryParse("${data['length']}"),
      price: double.tryParse("${data['price']}"),
      receive_name: "${data['receive_name'] ?? ''}",
      receive_address: "${data['receive_address'] ?? ''}",
      receive_phone: "${data['receive_phone'] ?? ''}",
      sender_name: "${data['sender_name'] ?? ''}",
      sender_phone: "${data['sender_phone'] ?? ''}",
      status: "${data['status'] ?? ''}",
      created_at: "${data['created_at'] ?? ''}",
      from: data['from'] != null ? UserModel.fromJson(data['from']) : null,
      to: data['to'] != null ? UserModel.fromJson(data['to']) : null,
    );
  }
}
