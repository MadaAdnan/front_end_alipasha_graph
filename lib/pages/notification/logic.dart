import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/notification_model.dart';
import 'package:get/get.dart';

class NotificationLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxInt page = RxInt(1);
  RxList<NotificationModel> notifications = RxList<NotificationModel>([]);

  nextPage() {
    if (hasMorePage.value) {
      page.value = page.value++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getNotifications();
  }


  getNotifications() async {
    loading.value = true;
    mainController.query.value = '''
  query Notifications {
    notifications(first: 10, page: 1) {
        data {
            data {
                title
                body
                url
            }
            created_at
        }
    }
}

  ''';
    try {
      var res = await mainController.fetchData();
      if (res?.data?['data']?['notifications']?['data'] != null) {
        for (var item in res?.data?['data']?['notifications']?['data']) {
          notifications.add(NotificationModel.fromJson(item));
        }
      }
    } catch (e) {}
    loading.value = false;
  }
}
