import 'package:ali_pasha_graph/pages/balance/binding.dart';
import 'package:ali_pasha_graph/pages/balance/view.dart';
import 'package:ali_pasha_graph/pages/create_product/binding.dart';
import 'package:ali_pasha_graph/pages/create_product/view.dart';
import 'package:ali_pasha_graph/pages/home/binding.dart';
import 'package:ali_pasha_graph/pages/home/view.dart';
import 'package:ali_pasha_graph/pages/menu/binding.dart';
import 'package:ali_pasha_graph/pages/menu/view.dart';
import 'package:ali_pasha_graph/pages/profile/binding.dart';
import 'package:ali_pasha_graph/pages/profile/view.dart';
import 'package:ali_pasha_graph/pages/shipping/binding.dart';
import 'package:ali_pasha_graph/pages/shipping/view.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';

import 'package:get/get.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(name: HOME_PAGE, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: CREATE_PRODUCT_PAGE,
        page: () => CreateProductPage(),
        binding: CreateProductBinding()),
    GetPage(name: MENU_PAGE, page: () => MenuPage(), binding: MenuBinding()),
    GetPage(
        name: PROFILE_PAGE,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: BALANCES_PAGE,
        page: () => BalancePage(),
        binding: BalanceBinding()),

    GetPage(
        name: SHIPPING_PAGE,
        page: () => ShippingPage(),
        binding: ShippingBinding()),
  ];
}
