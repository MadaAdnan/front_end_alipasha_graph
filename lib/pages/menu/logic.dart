import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class MenuLogic extends GetxController {

  MainController mainController =Get.find<MainController>();
RxString selectedValue1=RxString('asks');
RxString selectedValue2=RxString('settings');

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mainController. pusher
        .subscribe('chat')
        .bind('sent', (event) => mainController.logger.e('event =>' + event.toString()));
  }
}
