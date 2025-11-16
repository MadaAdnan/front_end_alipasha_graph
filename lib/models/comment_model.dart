import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CommentModel {
  int? id;
  int? productId;
  String? comment;
  int? commentID;
  UserModel? user;
  String? createdAt;
RxList<CommentModel>? comments;
  CommentModel({this.id, this.user, this.comment,this.createdAt,this.comments,this.productId,this.commentID});

  factory CommentModel.fromJson(Map<String, dynamic> data) {

      //Logger().i(data);

    RxList<CommentModel> commentsList=RxList([]);
    if(data['comments']!=null){
      for(var item in data['comments'] ){
        commentsList.add(CommentModel.fromJson(item));
      }
    }
    return CommentModel(
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      comment: "${data['comment']??''}",
      id: int.tryParse("${data['id']}"),
      productId: int.tryParse("${data['product_id']}"),
      commentID: int.tryParse("${data['comment_id']}"),
      createdAt: "${data['created_at']??''}",
      comments: commentsList
    );
  }
}
