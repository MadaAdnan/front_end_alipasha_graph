import 'package:logger/logger.dart';

class PrayerModel {
  String? fajr;
  String? sunrice;
  String? duhur;
  String? asr;
  String? magrib;
  String? isha;
  String? imsak;
  HijriDate? hijri;

  PrayerModel({
    this.asr,
    this.duhur,
    this.fajr,
    this.hijri,
    this.imsak,
    this.isha,
    this.magrib,
    this.sunrice,
  });

  factory PrayerModel.fromJson(Map<String,dynamic> data){
     Logger().w(data);
    PrayerModel p= PrayerModel(
      fajr: "${data['timings']?['Fajr']??''}".replaceFirst("(+03)", ''),
      sunrice: "${data['timings']?['Sunrise']??''}".replaceFirst("(+03)", ''),
      duhur: "${data['timings']?['Dhuhr']??''}".replaceFirst("(+03)", ''),
      asr: "${data['timings']?['Asr']??''}".replaceFirst("(+03)", ''),
      magrib: "${data['timings']?['Maghrib']??''}".replaceFirst("(+03)", ''),
      isha: "${data['timings']?['Isha']??''}".replaceFirst("(+03)", ''),
      imsak: "${data['timings']?['Imsak']??''}".replaceFirst("(+03)", ''),
      hijri: data['date']?['hijri'] !=null ?HijriDate.fromJson(data['date']?['hijri']) :null,
    );
    Logger().w(p.fajr);
    return p;
  }
}

class HijriDate {
  String? day;
  String? month;
  String? year;
  String? dayName;
  String? monthName;

  HijriDate({this.day, this.dayName, this.month, this.monthName, this.year});

  factory HijriDate.fromJson(Map<String, dynamic> data) {
    return HijriDate(
      day: "${data['day'] ?? ''}",
      year: "${data['year'] ?? ''}",
      dayName: "${data['weekday']?['ar'] ?? ''}",
      month: "${data['month']?['number'] ?? ''}",
      monthName: "${data['month']?['ar'] ?? ''}",
    );
  }
}
