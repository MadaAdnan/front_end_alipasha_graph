import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CommunityModel {
  int? id;
  UserModel? user;
  UserModel? seller;
  String? lastChange;
  RxInt receiveMessagesCount = RxInt(0);

  CommunityModel(
      {this.seller,
      this.user,
      this.id,
      this.lastChange,
      });

  factory CommunityModel.fromJson(Map<String, dynamic> data) {
    var comm= CommunityModel(
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      seller: data['user'] != null ? UserModel.fromJson(data['seller']) : null,
      id: int.tryParse("${data['id']}"),
      lastChange: "${data['last_change'] ?? ''}",
    );
    comm.receiveMessagesCount.value= int.tryParse("${data['not_seen_count']}") ?? 0;
    return comm;
  }
}
