import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

class SliderModel {
  int? id;
  String? url;
  String? image;
  CategoryModel? category;
  UserModel? user;
  String? expired_date;
  int? views_count;

  SliderModel({this.image,this.id,this.user,this.category,this.url,this.expired_date,this.views_count});


  SliderModel.fromJson(Map<String,dynamic> data){
    id=int.tryParse("${data['id']}");
    views_count=int.tryParse("${data['views_count']}")??0;
    url="${data['url']??''}";
    image="${data['image']??''}";
    expired_date="${data['expired_date']??''}";
    if(data['user']!=null){
      user=UserModel.fromJson(data['user']);
    }
    if(data['category']!=null){

      category=CategoryModel.fromJson(data['category']);
    }
  }
}
