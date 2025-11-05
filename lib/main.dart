import 'package:ali_pasha_graph/Global/main_binding.dart';
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/routes/route_pages.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:app_links/app_links.dart';
import 'package:clarity_flutter/clarity_flutter.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_meta_sdk/flutter_meta_sdk.dart';
import 'firebase_options.dart';


final metaSdk = FlutterMetaSdk();
/// https://www.figma.com/design/px6a4uJqQMFINZtOZtSPDP/ali-pasha-home?node-id=0-1&t=VcJBc4HEx3FehtIf-1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  final config = ClarityConfig(
    projectId: "ts1qh85xuj", // Replace with your Clarity project ID
    logLevel: LogLevel.Info, // Optional: verbose logging
  );

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final appLinks = AppLinks(); // AppLinks is singleton
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("af3a71bd-8c94-4d51-a39e-a9c9c84e0228");
  OneSignal.Notifications.requestPermission(true);
// Subscribe to all events (initial link and further)
  final sub = appLinks.uriLinkStream.listen((uri) {
    //  print('URI LINK IS : $uri');
  });

  await GetStorage.init('ali-pasha');
  Get.put(MainController(), permanent: true);
  await initializeDateFormatting('ar');

  runApp(
    ClarityWidget(
      app: MyApp(),
      clarityConfig: config,
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future<void> setupMessages(
      BuildContext context, NavigatorState navigator) async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      handleNavigation(message, context, navigator);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNavigation(message, context, navigator);
    });
  }

  void handleNavigation(
      RemoteMessage message, BuildContext context, NavigatorState navigator) {
    if (message.data['type'] == 'request') {
      Get.toNamed(NOTIFICATION_PAGE);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // يجعل شريط الحالة (Status Bar) شفاف

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupMessages(context, navigatorKey.currentState!);
    });
    _initFacebookSDK();
  }

  Future<void> _initFacebookSDK() async {
    try {
      metaSdk.activateApp();
      metaSdk.setAdvertiserTracking(enabled: true);


     /* await facebookAppEvents.setAdvertiserTracking(enabled: true);
      await facebookAppEvents.setAutoLogAppEventsEnabled(true);
      await facebookAppEvents.logEvent(name: 'fb_mobile_activate_app');*/
      print("Facebook SDK successfully");
    } catch (e) {
      print("Facebook SDK error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(1080, 2225),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        enableScaleText: () => false,
        builder: (_, child) => GetMaterialApp(
          navigatorKey: navigatorKey,
          defaultTransition: Transition.native,
          transitionDuration: Duration(milliseconds: 50),
          initialBinding: MainBinding(),
          title: 'علي باشا',
          locale: Locale('ar'),
          getPages: AppPages.pages,
          initialRoute: HOME_PAGE,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
