import 'package:laravel_flutter_pusher_plus/laravel_flutter_pusher_plus.dart';

class PusherService {
  static LaravelFlutterPusher init({String? token}) {
    var options = PusherOptions(
        host: '192.168.11.200', port: 6001, encrypted: false, cluster: 'mt1',auth: PusherAuth("http://192.168.11.200:8000/api/broadcasting/auth",headers: {
      'Authorization': 'Bearer $token', // تمرير الـ token هنا
      'Content-Type': 'application/json',
    }));

    LaravelFlutterPusher pusher =
        LaravelFlutterPusher('AliPasha', options, enableLogging: true,onError: (ConnectionError e)=>print("Error Pusher ${e.message}"),);
   return pusher;
  }
}
