import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart';

class PusherService {


  static PusherClient init({String? token}) {
    var options = PusherOptions(
      host: '85.215.154.88',
      encrypted: false,
      //
      // host: '192.168.11.200',
      // host: 'v3.ali-pasha.com:8086',
      wsPort: 6001,

      autoConnect: true,
      reconnectGap:Duration(seconds: 6) ,
      cluster: 'mt1',
      authOptions: PusherAuthOptions("http://pazarpasha.com/api/broadcasting/auth",
              // "http://192.168.11.200:8000/api/broadcasting/auth",
              headers: {
            if (token != null && token != '' )
              'Authorization': 'Bearer $token', // تمرير الـ token هنا
           //  'Content-Type': 'application/json',
             'Accept': 'application/json',
          }),
      key: 'AliPasha',
      enableLogging: true,
    );

 final   pusherClient = PusherClient(options: options);
    final logger = Logger();
    pusherClient.onConnected((data) {
      logger.w(data);
    });
    pusherClient.onConnectionEstablished((data) {
      logger.w("Connection established - socket-id: ${pusherClient.socketId}");
      // يمكنك استخدام Logger لطباعة الرسالة
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
