class AskModel{
  int? id;
  String? ask;
  String? answer;
  String? image;
  String? created_at;

  AskModel({this.id, this.ask, this.answer, this.created_at, this.image});

  AskModel.fromJson(Map<String, dynamic> json) {
    id =int.tryParse("${ json['id']}");
    ask = "${json['ask']??''}";
    answer ="${ json['answer']??''}";
    created_at = "${json['created_at']??''}";
    image = "${json['image']??''}";
  }
}