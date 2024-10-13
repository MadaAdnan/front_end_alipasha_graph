class DeepLinksService {
  DeepLinksService._();

  static init() async {
    String? initialLink = await getInitialLink();
    _processLink(initialLink);
  }

  static _processLink(String? link) {
    if (link != null) {
      var data = link.split('/');
      var id = data.last;

      if (link.contains("products")) {
        Get.toNamed(AppRouters.SHOW_PRODUCT_SCREEN,
            arguments: {"product_id": id, "fromLink": true});
      } else if (link.contains("tenders")) {
        Get.toNamed(AppRouters.SHOW_TENDER_SCREEN,
            arguments: {"product_id": id, "fromLink": true});
      } else if (link.contains("jobs")) {
        Get.toNamed(AppRouters.SHOW_JOB_SCREEN,
            arguments: {"product_id": id, "fromLink": true});
      } else if (link.contains("posts")) {
        Get.toNamed(AppRouters.SHOW_BLOG_POST_SCREEN,
            arguments: {"post_id": id, "fromLink": true});
      } else if (link.contains("sellers")) {
        Get.toNamed(AppRouters.SHOW_SELLER_SCREEN,
            arguments: {"seller_id": id});
      }
    }
  }
}