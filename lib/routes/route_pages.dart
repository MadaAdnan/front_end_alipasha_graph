import 'package:ali_pasha_graph/middlewares/active_privacy.dart';
import 'package:ali_pasha_graph/middlewares/complete_profile_middleware.dart';
import 'package:ali_pasha_graph/middlewares/guest_middleware.dart';
import 'package:ali_pasha_graph/middlewares/is_logged_in.dart';
import 'package:ali_pasha_graph/middlewares/verify_email_middleware.dart';
import 'package:ali_pasha_graph/pages/about/binding.dart';
import 'package:ali_pasha_graph/pages/about/view.dart';
import 'package:ali_pasha_graph/pages/agree_privacy/view.dart';
import 'package:ali_pasha_graph/pages/asks/binding.dart';
import 'package:ali_pasha_graph/pages/asks/view.dart';

import 'package:ali_pasha_graph/pages/balance/binding.dart';
import 'package:ali_pasha_graph/pages/balance/view.dart';
import 'package:ali_pasha_graph/pages/cart_item/binding.dart';
import 'package:ali_pasha_graph/pages/cart_item/view.dart';
import 'package:ali_pasha_graph/pages/cart_seller/binding.dart';
import 'package:ali_pasha_graph/pages/cart_seller/view.dart';
import 'package:ali_pasha_graph/pages/channel/binding.dart';
import 'package:ali_pasha_graph/pages/channel/view.dart';
import 'package:ali_pasha_graph/pages/chat/binding.dart';
import 'package:ali_pasha_graph/pages/chat/view.dart';
import 'package:ali_pasha_graph/pages/comment/binding.dart';
import 'package:ali_pasha_graph/pages/comment/view.dart';
import 'package:ali_pasha_graph/pages/communities/binding.dart';
import 'package:ali_pasha_graph/pages/communities/view.dart';
import 'package:ali_pasha_graph/pages/contact/binding.dart';
import 'package:ali_pasha_graph/pages/contact/view.dart';
import 'package:ali_pasha_graph/pages/create_advice/binding.dart';
import 'package:ali_pasha_graph/pages/create_advice/view.dart';
import 'package:ali_pasha_graph/pages/create_community/binding.dart';
import 'package:ali_pasha_graph/pages/create_community/view.dart';
import 'package:ali_pasha_graph/pages/create_job/binding.dart';
import 'package:ali_pasha_graph/pages/create_job/view.dart';
import 'package:ali_pasha_graph/pages/create_product/binding.dart';
import 'package:ali_pasha_graph/pages/create_product/view.dart';
import 'package:ali_pasha_graph/pages/create_service/binding.dart';
import 'package:ali_pasha_graph/pages/create_service/view.dart';
import 'package:ali_pasha_graph/pages/edit_job/binding.dart';
import 'package:ali_pasha_graph/pages/edit_job/view.dart';
import 'package:ali_pasha_graph/pages/edit_product/binding.dart';
import 'package:ali_pasha_graph/pages/edit_product/view.dart';
import 'package:ali_pasha_graph/pages/edit_profile/binding.dart';
import 'package:ali_pasha_graph/pages/edit_profile/view.dart';
import 'package:ali_pasha_graph/pages/edit_service/binding.dart';
import 'package:ali_pasha_graph/pages/edit_service/view.dart';
import 'package:ali_pasha_graph/pages/edit_tender/binding.dart';
import 'package:ali_pasha_graph/pages/edit_tender/view.dart';

import 'package:ali_pasha_graph/pages/filter/binding.dart';
import 'package:ali_pasha_graph/pages/filter/view.dart';
import 'package:ali_pasha_graph/pages/followers/binding.dart';
import 'package:ali_pasha_graph/pages/followers/view.dart';
import 'package:ali_pasha_graph/pages/gallery/binding.dart';
import 'package:ali_pasha_graph/pages/gallery/view.dart';
import 'package:ali_pasha_graph/pages/gold/binding.dart';
import 'package:ali_pasha_graph/pages/gold/view.dart';
import 'package:ali_pasha_graph/pages/group/binding.dart';
import 'package:ali_pasha_graph/pages/group/view.dart';
import 'package:ali_pasha_graph/pages/home/binding.dart';
import 'package:ali_pasha_graph/pages/home/view.dart';
import 'package:ali_pasha_graph/pages/jobs/binding.dart';
import 'package:ali_pasha_graph/pages/jobs/view.dart';
import 'package:ali_pasha_graph/pages/live/binding.dart';
import 'package:ali_pasha_graph/pages/live/view.dart';
import 'package:ali_pasha_graph/pages/login/binding.dart';
import 'package:ali_pasha_graph/pages/login/view.dart';
import 'package:ali_pasha_graph/pages/maintenance/binding.dart';
import 'package:ali_pasha_graph/pages/maintenance/view.dart';

import 'package:ali_pasha_graph/pages/menu/binding.dart';
import 'package:ali_pasha_graph/pages/menu/view.dart';
import 'package:ali_pasha_graph/pages/my_invoice/binding.dart';
import 'package:ali_pasha_graph/pages/my_invoice/view.dart';
import 'package:ali_pasha_graph/pages/new_details/binding.dart';
import 'package:ali_pasha_graph/pages/new_details/view.dart';
import 'package:ali_pasha_graph/pages/notification/binding.dart';
import 'package:ali_pasha_graph/pages/notification/view.dart';
import 'package:ali_pasha_graph/pages/orders/binding.dart';
import 'package:ali_pasha_graph/pages/orders/view.dart';
import 'package:ali_pasha_graph/pages/partner/binding.dart';
import 'package:ali_pasha_graph/pages/partner/view.dart';
import 'package:ali_pasha_graph/pages/pdf/binding.dart';
import 'package:ali_pasha_graph/pages/pdf/view.dart';
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
import 'package:ali_pasha_graph/pages/restaurant/binding.dart';
import 'package:ali_pasha_graph/pages/restaurant/view.dart';
import 'package:ali_pasha_graph/pages/search/binding.dart';
import 'package:ali_pasha_graph/pages/search/view.dart';
import 'package:ali_pasha_graph/pages/sections/binding.dart';
import 'package:ali_pasha_graph/pages/sections/view.dart';
import 'package:ali_pasha_graph/pages/sellers/binding.dart';
import 'package:ali_pasha_graph/pages/sellers/view.dart';
import 'package:ali_pasha_graph/pages/service/view.dart';
import 'package:ali_pasha_graph/pages/service_details/binding.dart';
import 'package:ali_pasha_graph/pages/service_details/view.dart';
import 'package:ali_pasha_graph/pages/services/binding.dart';
import 'package:ali_pasha_graph/pages/services/view.dart';
import 'package:ali_pasha_graph/pages/shipping/binding.dart';
import 'package:ali_pasha_graph/pages/shipping/view.dart';
import 'package:ali_pasha_graph/pages/tenders/binding.dart';
import 'package:ali_pasha_graph/pages/tenders/view.dart';
import 'package:ali_pasha_graph/pages/test/binding.dart';
import 'package:ali_pasha_graph/pages/test/view.dart';
import 'package:ali_pasha_graph/pages/verify_email/binding.dart';
import 'package:ali_pasha_graph/pages/verify_email/view.dart';
import 'package:ali_pasha_graph/pages/video_player_post/binding.dart';
import 'package:ali_pasha_graph/pages/video_player_post/view.dart';

import 'package:ali_pasha_graph/pages/weather/binding.dart';
import 'package:ali_pasha_graph/pages/weather/view.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';

import 'package:get/get.dart';

import '../pages/agree_privacy/binding.dart';
import '../pages/ask/binding.dart';
import '../pages/ask/view.dart';
import '../pages/create_tender/binding.dart';
import '../pages/create_tender/view.dart';

import '../pages/following/binding.dart';
import '../pages/following/view.dart';
import '../pages/forget_password/binding.dart';
import '../pages/forget_password/view.dart';
import '../pages/invoices/binding.dart';
import '../pages/invoices/view.dart';
import '../pages/news/binding.dart';
import '../pages/news/view.dart';
import '../pages/products/binding.dart';
import '../pages/products/view.dart';
import '../pages/section/binding.dart';
import '../pages/section/view.dart';
import '../pages/service/binding.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: HOME_PAGE,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [ActivePrivacyMiddleware()],
    ),
    GetPage(
      name: NEW_DETAILS,
      page: () => NewDetailsPage(),
      binding: NewDetailsBinding(),
      middlewares: [],
    ),
    GetPage(
      name: ACTIVE_PRIVACY,
      page: () => AgreePrivacyPage(),
      binding: AgreePrivacyBinding(),
      middlewares: [],
    ),
    GetPage(
      name: PDF_PAGE,
      page: () => PdfPage(),
      binding: PdfBinding(),
      middlewares: [],
    ),


    GetPage(
      name: RESTAURANT_PAGE,
      page: () => RestaurantPage(),
      binding: RestaurantBinding(),
      middlewares: [],
    ),

    GetPage(
      name: MAINTENANCE_PAGE,
      page: () => MaintenancePage(),
      binding: MaintenanceBinding(),
      middlewares: [],
    ),

    GetPage(
      name: GALLERY_PAGE,
      page: () => GalleryPage(),
      binding: GalleryBinding(),
      middlewares: [],
    ),
    GetPage(
      name: COMMENTS_PAGE,
      page: () => CommentPage(),
      binding: CommentBinding(),
      middlewares: [],
    ),

    GetPage(
      name: TEST_PAGE,
      page: () => TestPage(),
      binding: TestBinding(),
      middlewares: [],
    ),




    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: CREATE_PRODUCT_PAGE,
        page: () => CreateProductPage(),
        binding: CreateProductBinding()),


    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: CREATE_ADVICE_PAGE,
        page: () => CreateAdvicePage(),
        binding: CreateAdviceBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: MY_INVOICE_PAGE,
        page: () => MyInvoicePage(),
        binding: MyInvoiceBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: INVOICE_PAGE,
        page: () => InvoicesPage(),
        binding: InvoicesBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: NOTIFICATION_PAGE,
        page: () => NotificationPage(),
        binding: NotificationBinding()),


    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: MY_ORDER_SHIPPING_PAGE,
        page: () => OrdersPage(),
        binding: OrdersBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: CREATE_JOB_PAGE,
        page: () => CreateJobPage(),
        binding: CreateJobBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: CREATE_TENDER_PAGE,
        page: () => CreateTenderPage(),
        binding: CreateTenderBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: CREATE_SERVICE_PAGE,
        page: () => CreateServicePage(),
        binding: CreateServiceBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: Edit_SERVICE_PAGE,
        page: () => EditServicePage(),
        binding: EditServiceBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: Edit_TENDER_PAGE,
        page: () => EditTenderPage(),
        binding: EditTenderBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: Edit_JOB_PAGE,
        page: () => EditJobPage(),
        binding: EditJobBinding()),

    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: Edit_PRODUCT_PAGE,
        page: () => EditProductPage(),
        binding: EditProductBinding()),

    GetPage(
        name: CART_SELLER,
        page: () => CartSellerPage(),
        binding: CartSellerBinding()),

    GetPage(
        name: CART_ITEM,
        page: () => CartItemPage(),
        binding: CartItemBinding()),





    GetPage(name: MENU_PAGE, page: () => MenuPage(), binding: MenuBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: PROFILE_PAGE,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
        name: BALANCES_PAGE,
        page: () => BalancePage(),
        binding: BalanceBinding()),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: SHIPPING_PAGE,
      page: () => ShippingPage(),
      binding: ShippingBinding(),
    ),
    GetPage(
      middlewares: [GuestMiddleware()],
      name: LOGIN_PAGE,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      middlewares: [GuestMiddleware()],
      name: FORGET_PASSWORD_PAGE,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      middlewares: [GuestMiddleware()],
      name: REGISTER_PAGE,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: VERIFY_EMAIL_PAGE,
      page: () => VerifyEmailPage(),
      binding: VerifyEmailBinding(),
    ),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: FOLLOWERS_PAGE,
      page: () => FollowersPage(),
      binding: FollowersBinding(),
    ),

    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: FOLLOWING_PAGE,
      page: () => FollowingPage(),
      binding: FollowingBinding(),
    ),

    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: CREATE_COMMUNITY_PAGE,
      page: () => CreateCommunityPage(),
      binding: CreateCommunityBinding(),
    ),



    GetPage(
      name: JOBS_PAGE,
      page: () => JobsPage(),
      binding: JobsBinding(),
    ),

    GetPage(
      name: VIDEO_PLAYER_POST_PAGE,
      page: () => VideoPlayerPostPage(),
      binding: VideoPlayerPostBinding(),
    ),


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
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: COMMUNITIES_PAGE,
      page: () => CommunitiesPage(),
      binding: CommunitiesBinding(),
    ),
    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: CHAT_PAGE,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: GROUP_PAGE,
      page: () => GroupPage(),
      binding: GroupBinding(),
    ),

    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
      name: CHANNEL_PAGE,
      page: () => ChannelPage(),
      binding: ChannelBinding(),
    ),


    GetPage(
      middlewares: [IsLoggedIn(), VerifyEmailMiddleware(),CompleteProfileMiddleware()],
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
      name: ASKS_PAGE,
      page: () => AsksPage(),
      binding: AsksBinding(),
    ),

    GetPage(
      name: LIVE_PAGE,
      page: () => LivePage(),
      binding: LiveBinding(),
    ),


    GetPage(
      name: ASK_PAGE,
      page: () => AskPage(),
      binding: AskBinding(),
    ),
    GetPage(
      name: CONTACT_US_PAGE,
      page: () => ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: PARTNER_PAGE,
      page: () => PartnerPage(),
      binding: PartnerBinding(),
    ),
    GetPage(
      name: SELLERS_PAGE,
      page: () => SellersPage(),
      binding: SellersBinding(),
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
