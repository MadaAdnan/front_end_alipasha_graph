import 'package:laravel_flutter_pusher_plus/laravel_flutter_pusher_plus.dart';

class PusherService {
  static LaravelFlutterPusher init() {
    var options = PusherOptions(
        host: '192.168.11.200', port: 6001, encrypted: false, cluster: 'mt1',);

    LaravelFlutterPusher pusher =
        LaravelFlutterPusher('AliPasha', options, enableLogging: true);
   return pusher;
  }
}
