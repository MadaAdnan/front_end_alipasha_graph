class NotificationModel {
  String? created_at;
  DataNotification? data;
  NotificationModel({this.data,this.created_at});
  
  factory NotificationModel.fromJson(Map<String,dynamic> data){
    return NotificationModel(created_at: "${data['created_at']??''}",data: data['data']!=null ?DataNotification.fromJson(data['data']):null);
  }
}

class DataNotification{
  String? title;
  String? body;
  String? url;
  DataNotification({this.url,this.body,this.title});
  
  factory DataNotification.fromJson(Map<String,dynamic> data){
    return DataNotification(
      title: "${data['title']??''}",
      body: "${data['body']??''}",
      url: "${data['url']??''}",
    );
  }
}