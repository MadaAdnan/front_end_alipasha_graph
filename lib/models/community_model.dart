import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
class PivotCommunity{
  bool?is_manager;
  bool? notify;
  PivotCommunity({this.is_manager,this.notify});

  factory PivotCommunity.fromJson(Map<String,dynamic> data){
    return PivotCommunity(is_manager: bool.tryParse("${data['is_manager']}")??false,notify: bool.tryParse("${data['notify']}")??false);
  }
}
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
int? unRead;
String? image;
PivotCommunity? pivotCommunity;

  CommunityModel({
    this.manager,
    this.users,
    this.id,
    this.lastChange,
    this.users_count,
    this.type,
    this.name,
    this.url,
    this.unRead,
    this.image,
    this.pivotCommunity,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> data) {
    List<UserModel> subscribes = [];
    if (data['users'] != null) {
      for (var item in data['users']) {
        subscribes.add(UserModel.fromJson(item));
      }
    }

    return CommunityModel(
      users: subscribes,
      manager: data['manager'] != null ? UserModel.fromJson(data['manager']) : null,
      id: int.tryParse("${data['id']}"),
      users_count: int.tryParse("${data['users_count']}")??0,
      unRead: int.tryParse("${data['un_read']}")??0,
      lastChange: "${data['last_update'] ?? ''}",
      name: "${data['name'] ?? ''}",
      type: "${data['type'] ?? ''}",
      url: "${data['url'] ?? ''}",
      image: "${data['image'] ?? ''}",
      pivotCommunity: data['pivot']!=null ? PivotCommunity.fromJson(data['pivot']) :null
    );

  }
}
