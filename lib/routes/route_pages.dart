import 'package:ali_pasha_graph/middlewares/guest_middleware.dart';
import 'package:ali_pasha_graph/middlewares/is_logged_in.dart';
import 'package:ali_pasha_graph/middlewares/verify_email_middleware.dart';
import 'package:ali_pasha_graph/pages/about/binding.dart';
import 'package:ali_pasha_graph/pages/about/view.dart';

import 'package:ali_pasha_graph/pages/balance/binding.dart';
import 'package:ali_pasha_graph/pages/balance/view.dart';
import 'package:ali_pasha_graph/pages/chat/binding.dart';
import 'package:ali_pasha_graph/pages/chat/view.dart';
import 'package:ali_pasha_graph/pages/communities/binding.dart';
import 'package:ali_pasha_graph/pages/communities/view.dart';
import 'package:ali_pasha_graph/pages/create_product/binding.dart';
import 'package:ali_pasha_graph/pages/create_product/view.dart';
import 'package:ali_pasha_graph/pages/edit_profile/binding.dart';
import 'package:ali_pasha_graph/pages/edit_profile/view.dart';


import 'package:ali_pasha_graph/pages/filter/binding.dart';
import 'package:ali_pasha_graph/pages/filter/view.dart';
import 'package:ali_pasha_graph/pages/followers/binding.dart';
import 'package:ali_pasha_graph/pages/followers/view.dart';
import 'package:ali_pasha_graph/pages/gold/binding.dart';
import 'package:ali_pasha_graph/pages/gold/view.dart';
import 'package:ali_pasha_graph/pages/home/binding.dart';
import 'package:ali_pasha_graph/pages/home/view.dart';
import 'package:ali_pasha_graph/pages/jobs/binding.dart';
import 'package:ali_pasha_graph/pages/jobs/view.dart';
import 'package:ali_pasha_graph/pages/login/binding.dart';
import 'package:ali_pasha_graph/pages/login/view.dart';

import 'package:ali_pasha_graph/pages/menu/binding.dart';
import 'package:ali_pasha_graph/pages/menu/view.dart';
import 'package:ali_pasha_graph/pages/plan/binding.dart';
import 'package:ali_pasha_graph/pages/plan/view.dart';
import 'package:ali_pasha_graph/pages/prayer/binding.dart';
import 'package:ali_pasha_graph/pages/prayer/view.dart';
import 'package:ali_pasha_graph/pages/privacy/binding.dart';
import 'package:ali_pasha_graph/pages/privacy/view.dart';
import 'package:ali_pasha_graph/pages/product/binding.dart';
import 'package:ali_pasha_graph/pages/product/view.dart';
import 'package:ali_pasha_graph/pages/profile/binding.dart';
import 'package:ali_pasha_graph/pages/profile/view.dart';
import 'package:ali_pasha_graph/pages/register/binding.dart';
import 'package:ali_pasha_graph/pages/register/view.dart';
import 'package:ali_pasha_graph/pages/search/binding.dart';
import 'package:ali_pasha_graph/pages/search/view.dart';
import 'package:ali_pasha_graph/pages/sections/binding.dart';
import 'package:ali_pasha_graph/pages/sections/view.dart';
import 'package:ali_pasha_graph/pages/service/view.dart';
import 'package:ali_pasha_graph/pages/service_details/binding.dart';
import 'package:ali_pasha_graph/pages/service_details/view.dart';
import 'package:ali_pasha_graph/pages/services/binding.dart';
import 'package:ali_pasha_graph/pages/services/view.dart';
import 'package:ali_pasha_graph/pages/shipping/binding.dart';
import 'package:ali_pasha_graph/pages/shipping/view.dart';
import 'package:ali_pasha_graph/pages/tenders/binding.dart';
import 'package:ali_pasha_graph/pages/tenders/view.dart';
import 'package:ali_pasha_graph/pages/verify_email/binding.dart';
import 'package:ali_pasha_graph/pages/verify_email/view.dart';
import 'package:ali_pasha_graph/pages/weather/binding.dart';
import 'package:ali_pasha_graph/pages/weather/view.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';

import 'package:get/get.dart';

import '../pages/news/binding.dart';
import '../pages/news/view.dart';
import '../pages/products/binding.dart';
import '../pages/products/view.dart';
import '../pages/section/binding.dart';
import '../pages/section/view.dart';
import '../pages/service/binding.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(name: HOME_PAGE, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
        name: CREATE_PRODUCT_PAGE,
        page: () => CreateProductPage(),
        binding: CreateProductBinding()),
    GetPage(name: MENU_PAGE, page: () => MenuPage(), binding: MenuBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
        name: PROFILE_PAGE,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
        name: BALANCES_PAGE,
        page: () => BalancePage(),
        binding: BalanceBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
        name: SHIPPING_PAGE,
        page: () => ShippingPage(),
        binding: ShippingBinding(),),
    GetPage(
        middlewares: [GuestMiddleware()],
        name: LOGIN_PAGE,
        page: () => LoginPage(),
        binding: LoginBinding(),),
    GetPage(
        middlewares: [GuestMiddleware()],
        name: REGISTER_PAGE,
        page: () => RegisterPage(),
        binding: RegisterBinding(),),
    GetPage(
        name: VERIFY_EMAIL_PAGE,
        page: () => VerifyEmailPage(),
        binding: VerifyEmailBinding(),),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
        name: FOLLOWERS_PAGE,
        page: () => FollowersPage(),
        binding: FollowersBinding(),),
    GetPage(name: JOBS_PAGE, page: () => JobsPage(), binding: JobsBinding(),),
    GetPage(
        name: TENDERS_PAGE,
        page: () => TendersPage(),
        binding: TendersBinding()),
    GetPage(
      name: SECTIONS_PAGE,
      page: () => SectionsPage(),
      binding: SectionsBinding(),
    ),
    GetPage(
      name: SECTION_PAGE,
      page: () => SectionPage(),
      binding: SectionBinding(),
    ),
    GetPage(
      name: PRODUCT_PAGE,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: PRODUCTS_PAGE,
      page: () => ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: FILTER_PAGE,
      page: () => FilterPage(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: SEARCH_PAGE,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
      name: COMMUNITIES_PAGE,
      page: () => CommunitiesPage(),
      binding: CommunitiesBinding(),
    ),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
      name: CHAT_PAGE,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
      name: PLAN_PAGE,
      page: () => PlanPage(),
      binding: PlanBinding(),
    ),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware()],
      name: Edit_PROFILE_PAGE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),



    GetPage(
      name: GOLD_PAGE,
      page: () => GoldPage(),
      binding: GoldBinding(),
    ),


    GetPage(
      name: NEWS_PAGE,
      page: () => NewsPage(),
      binding: NewsBinding(),
    ),

    GetPage(
      name: PRIVACY_PAGE,
      page: () => PrivacyPage(),
      binding: PrivacyBinding(),
    ),

    GetPage(
      name: ABOUT_PAGE,
      page: () => AboutPage(),
      binding: AboutBinding(),
    ),




    GetPage(
      name: PRAYER_PAGE,
      page: () => PrayerPage(),
      binding: PrayerBinding(),
    ),

    GetPage(
      name: SERVICES_PAGE,
      page: () => ServicesPage(),
      binding: ServicesBinding(),
    ),

    GetPage(
      name: WEATHER_PAGE,
      page: () => WeatherPage(),
      binding: WeatherBinding(),
    ),

    GetPage(
      name: SERVICE_PAGE,
      page: () => ServicePage(),
      binding: ServiceBinding(),
    ),

    GetPage(
      name: SERVICE_DETAILS,
      page: () => ServiceDetailsPage(),
      binding: ServiceDetailsBinding(),
    ),
  ];
}
//https://api.weatherapi.com/v1/current.json?key=b0eaa5c40b5d4334802113456242408&q=Aazaz
