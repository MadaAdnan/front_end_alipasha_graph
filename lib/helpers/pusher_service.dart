import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/setting_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart';
// import 'package:laravel_flutter_pusher_plus/laravel_flutter_pusher_plus.dart';

class PusherService {

  static PusherClient init({String? token}) {

    var options = PusherOptions(
        host: '85.215.154.88:8081',
        protocol:Protocol.ws,
        autoConnect: false,
        cluster: 'mt1',
        authOptions: PusherAuthOptions("http://v3.ali-pasha.com/api/broadcasting/auth",
            headers: {
              if (token!=null && token!='')
                'Authorization': 'Bearer $token', // تمرير الـ token هنا
              'Content-Type': 'application/json',
            }), key: 'AliPasha',enableLogging: true,);

    final pusherClient = PusherClient( options: options);
    final logger=Logger();
    pusherClient.onConnected((data){
logger.w(data);

    });
    pusherClient.onConnectionEstablished((data) {
      logger.w("Connection established - socket-id: ${pusherClient.socketId}");
    });
    pusherClient.onConnectionError((error) {
      logger.w("Connection error - $error");
    });
    pusherClient.onError((error) {
      logger.w("Error - $error");
    });
    pusherClient.onDisconnected((data) {
      logger.w("Disconnected - $data");
    });
    pusherClient.connect();

    return pusherClient;
  }

}
