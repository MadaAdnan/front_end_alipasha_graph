import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CommunityModel {
  int? id;
  List<UserModel>? users;
  UserModel? manager;
  String? lastChange;
  RxInt receiveMessagesCount = RxInt(0);
  String? url;
  String? name;
  String? type;
  int? users_count;

  CommunityModel({
    this.manager,
    this.users,
    this.id,
    this.lastChange,
    this.users_count,
    this.type,
    this.name,
    this.url,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> data) {
    List<UserModel> subscribes = [];
    if (data['users'] != null) {
      for (var item in data['users']) {
        subscribes.add(UserModel.fromJson(item));
      }
    }

    var comm = CommunityModel(
      users: subscribes,
      manager: data['manager'] != null ? UserModel.fromJson(data['manager']) : null,
      id: int.tryParse("${data['id']}"),
      users_count: int.tryParse("${data['users_count']}")??0,
      lastChange: "${data['last_update'] ?? ''}",
      name: "${data['name'] ?? ''}",
      type: "${data['type'] ?? ''}",
      url: "${data['url'] ?? ''}",

    );
   /* comm.receiveMessagesCount.value =
        int.tryParse("${data['not_seen_count']}") ?? 0;*/
    return comm;
  }
}
