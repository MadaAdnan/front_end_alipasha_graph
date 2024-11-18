import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

class MessageModel {
  int id;
  UserModel? user;
  String? body;
  String? attach;
  String? type;
  String? createdAt;
  CommunityModel? community;

  MessageModel({this.user, this.attach, this.body, this.createdAt,this.type,this.community,required this.id});

  factory MessageModel.fromJson(Map<String, dynamic> data) {

    return MessageModel(
      id:int.tryParse("${data['id']}")??0,
        user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
        createdAt: "${data['created_at'] ?? ''}",
        body: "${data['body'] ?? ''}",
        type: "${data['type'] ?? ''}",
        attach: "${data['attach'] ?? ''}",
    community: data['community']!=null?CommunityModel.fromJson(data['community']):null,
    );
  }

  toJson(){
    return {
      'id':id,
      'user':user?.toJson(),
      'body':body,
      'type':type,
      'attach':attach,
      'community':community?.toJson(),
      'created_at':createdAt,
    };
  }
}
