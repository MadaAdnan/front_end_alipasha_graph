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
    print(data);
    return PrayerModel(
      fajr: "${data['timings']?['Fajr']??''}",
      sunrice: "${data['timings']?['Sunrise']??''}",
      duhur: "${data['timings']?['Dhuhr']??''}",
      asr: "${data['timings']?['Asr']??''}",
      magrib: "${data['timings']?['Maghrib']??''}",
      isha: "${data['timings']?['Isha']??''}",
      imsak: "${data['timings']?['Imsak']??''}",
      hijri: data['date']?['hijri'] !=null ?HijriDate.fromJson(data['date']?['hijri']) :null,
    );
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
