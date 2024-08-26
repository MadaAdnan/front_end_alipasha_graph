class WeatherModel{
  String? temp_c;
  String? icon;
  String? wind;
  String? text;
  String? date;

  WeatherModel({this.text,this.icon,this.temp_c,this.wind,this.date});


  factory WeatherModel.fromJson(Map<String,dynamic> data){

    return WeatherModel(
      text: "${data['hour']?[13]?['condition']?['text'] ??''}".trim(),
      wind: "${data['hour']?[13]?['wind_kph']??''}",
      temp_c: "${data['hour']?[13]?['temp_c']??''}",
      icon: "https:${data['hour']?[13]?['condition']['icon']??''}",
      date: "${data['date']??''}",
    );
  }
}