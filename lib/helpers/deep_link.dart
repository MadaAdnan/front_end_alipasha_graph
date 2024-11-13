
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter_deep_links/flutter_deep_links.dart';
import 'package:get/get.dart';

class DeepLinksService {
  DeepLinksService._();

  static init() async {
    var link=FlutterDeepLinks();
    String? initialLink = await link.getInitialLink();
    _processLink(initialLink);
  }

  static _processLink(String? link) {
    if (link != null) {
      var data = link.split('/');
      var id = data.last;
      if (link.contains("products")) {
       Get.toNamed(PRODUCT_PAGE,parameters: {"id":id});
      }
    }
  }
}