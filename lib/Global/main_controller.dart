import 'dart:io';

import 'package:ali_pasha_graph/helpers/cart_helper.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/google_auth.dart';

import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/helpers/redcord_manager.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/cart_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/message_community_model.dart';
import 'package:ali_pasha_graph/models/pricing_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/setting_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/pages/channel/logic.dart';
import 'package:ali_pasha_graph/pages/chat/logic.dart';
import 'package:ali_pasha_graph/pages/communities/logic.dart';
import 'package:ali_pasha_graph/pages/group/logic.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart';

import '../exceptions/custom_exception.dart';
import '../helpers/colors.dart';
import '../helpers/deep_link.dart';
import '../helpers/dio_network_manager.dart';
import '../helpers/pusher_service.dart';
import '../models/city_model.dart';

class MainController extends GetxController {
  RxList<CartModel> carts = RxList<CartModel>([]);
  RxnString token = RxnString(null);
  Rxn<UserModel> authUser = Rxn<UserModel>(null);
  NetworkManager dio_manager = NetworkManager();
  GetStorage storage = GetStorage('ali-pasha');
  RxnString query = RxnString(null);
  Rxn<Map<String, dynamic>> variables = Rxn(null);
  RxBool isPlayAudio = RxBool(false);
  RxBool loading = RxBool(false);
  RxBool createCommunityLodaing = RxBool(false);
  RxBool cartLoading = RxBool(false);
  RxList<Map<String, dynamic>> errors = RxList<Map<String, dynamic>>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CityModel> cities = RxList<CityModel>([]);
  RxList<ColorModel> colors = RxList<ColorModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);
  RxList<SliderModel> sliders = RxList<SliderModel>([]);
  RxList<PricingModel> pricing = RxList([]);
  String versionAPK = "3.0.0";
  RxInt communityNotification = RxInt(0);
  RxBool startApp = RxBool(true); //for fill data from storage
  Rx<SettingModel> settings =
      Rx(SettingModel(weather_api: '02b438a76f5345c3857124556240809'));
  RxBool is_show_home_appbar = RxBool(true);
  Logger logger = Logger();
  Rxn<PusherClient> pusher = Rxn<PusherClient>(null);
  late dynamic deep;
  List<Channel> channels = [];

  @override
  void onInit() {
    super.onInit();
    DeepLinksService.init();
    checkStatusApp().then(
        (value) => value != true ? Get.offAndToNamed(MAINTENANCE_PAGE) : null);

    CartHelper.getCart().then((value) {
      carts(value);
    });

    ever(token, (value) {
      if (value != null && value.length > 30) {
        getMe();
      }
      try {} catch (e) {}
      if (value == null) {
        storage.remove('token');
        storage.remove('user');
      }
    });

    getUserFromStorage();
    getAdvices();
    getPricingData();
    pusher.value = PusherService.init(token: "${token.value}");
    ever(pusher, (value) {
      if (value != null) {
        globalChannelSubscribe();
        if (authUser.value?.id != null) {
          var createCommunityChannel =
              pusher.value!.channel('community.${authUser.value?.id}');
          createCommunityChannel.bind('community.create', (e) {
            getMe();
          });
          for (var item in authUser.value?.communities ?? []) {
            communitySubscribe(
                'private-message.${item?.id}.${authUser.value?.id}');
          }
        }
      } else {
        pusher.value = PusherService.init(token: "${token.value}");
      }
    });
    ever(authUser, (value) {
      if (value != null) {
        resubscribeAllChannels();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  globalChannelSubscribe() {
    var channel = pusher.value!.channel('change-setting');
    channel.bind('update-setting', (e) {
      logger.w(e);
      if (e['setting'] != null) {
        settings.value = SettingModel.fromJson(e['setting']);
      }
    });
    channels.add(channel);
  }

  communitySubscribe(String channelName) {



    Channel channel = pusher.value!.subscribe(channelName);

    channels.add(channel);
    channel.bind('message.create', handelEventCommunity);
  }

  handelEventCommunity(e) {
    if (e['message']['user']['id'] != authUser.value?.id) {
      if (Get.currentRoute != CHAT_PAGE &&
          Get.currentRoute != COMMUNITIES_PAGE) {
        communityNotification.value += 1;
      }
      // community Page
      else if (Get.currentRoute == COMMUNITIES_PAGE) {
        if (e['message']?['community'] != null) {
          CommunityModel community =
              CommunityModel.fromJson(e['message']?['community']);
          int index = Get.find<CommunitiesLogic>()
              .communities
              .indexWhere((el) => el.id == community.id);
          if (index == -1) {
            Get.find<CommunitiesLogic>().communities.insert(0, community);
          } else {
            Get.find<CommunitiesLogic>().communities.removeAt(index);

            Get.find<CommunitiesLogic>().communities.insert(0, community);
          }
        }
      }

      // Chat Page
      else if (Get.currentRoute == CHAT_PAGE ||
          Get.currentRoute == GROUP_PAGE ||
          Get.currentRoute == CHANNEL_PAGE) {
        if (e['message'] != null) {
          MessageModel message = MessageModel.fromJson(e['message']);
          switch (message.community?.type) {
            case 'chat':
              if (Get.currentRoute == CHAT_PAGE) {
                ChatLogic logic = Get.find<ChatLogic>();
                logic.messages.insert(0, message);
                logger.w("ADD MESSAGE");
                RecorderManager()
                    .playRecordedAudioNetWork(assets: 'sound/notify.mp3');
                loading.value = false;
              }
              break;
            case 'group':
              if (Get.currentRoute == GROUP_PAGE &&
                  message.user?.id != authUser.value?.id) {
                GroupLogic logic = Get.find<GroupLogic>();
                logic.messages.insert(0, message);
                //  RecorderManager().playRecordedAudioNetWork(assets: 'sound/notify.mp3');
                loading.value = false;
              }
              break;
            case 'channel':
              if (Get.currentRoute == CHANNEL_PAGE &&
                  message.user?.id != authUser.value?.id) {
                ChannelLogic logic = Get.find<ChannelLogic>();
                logic.messages.insert(0, message);
                RecorderManager()
                    .playRecordedAudioNetWork(assets: 'sound/notify.mp3');
                loading.value = false;
              }
              break;
          }
        }
      }
    }
  }

  void resubscribeAllChannels() {
    if (pusher.value != null) {
      pusher.value!.disconnect();
      pusher.value = PusherService.init(token: "${token.value}");
      pusher.value!.connect();
    }
    for (var channel in channels) {
      pusher.value!.unsubscribe(channel.name);
      var newChannel = pusher.value!.subscribe(channel.name);
      newChannel.bind('message.create', handelEventCommunity);
      logger.w('Re-subscribed to channel: ${channel.name}');
    }
  }

  Future<dio.Response?> fetchData() async {
    loading.value = true;
    DateTime startDate = DateTime.now();
    try {
      dio.Response res = await dio_manager.executeGraphQLQuery(query.value!,
          variables: variables.value);

      // logger.e(res.data);
      loading.value = false;
      DateTime endDate = DateTime.now();
      Duration responseTime = endDate.difference(startDate);
      logger.i(
          "Duration Response : ${responseTime.inMilliseconds / 1000} Seconds");
      logger.i("Response Size: ${res.data.toString().length / 1024} KB");
      return res;
    } on dio.DioException catch (e) {
      loading.value = false;
      throw CustomException(errors: {"errors": e}, message: e.message);
    } on HttpException catch (e) {
      loading.value = false;
      throw CustomException(errors: {"errors": e}, message: e.message);
    } catch (e) {
      loading.value = false;
      throw CustomException(errors: {"errors": e}, message: "خطأ بالسيرفر");
    }
  }

  void showToast({String? text, String type = 'success'}) {
    if (type == 'success') {
      CherryToast.success(
        title: Text(text ?? 'نجاح العملية', style: H3RegularDark),
      ).show(Get.context as BuildContext);
    } else {
      CherryToast.error(
        title: Text(text ?? 'فشل العملية', style: H3RegularDark),
      ).show(Get.context as BuildContext);
    }
  }

  getUser() {
    if (storage.hasData('user')) {
      var json = storage.read('user');
      authUser.value = UserModel.fromJson(json);
    }
  }

  Future<void> setUserJson({required Map<String, dynamic> json}) async {
    try {
      if (storage.hasData('user')) {
        await storage.remove('user');
      }
      authUser.value = null;
      await storage.write('user', json);

      authUser.value = UserModel.fromJson(json);
    } catch (e) {
      logger.e("Error Write Storage : $e");
    }
  }

  Future<void> setToken({String? token, bool isWrite = false}) async {
    if (isWrite) {
      if (storage.hasData('token')) {
        await storage.remove('token');
      }
      if (token != null) {
        await storage.write('token', token);
      }
    }
  }

  getUserFromStorage() {
    if (storage.hasData('user')) {
      var user = storage.read('user');
      authUser.value = UserModel.fromJson(user);
    }

    if (storage.hasData('token')) {
      String? tokenStored = storage.read('token');
      token.value = tokenStored;
    }
  }

  logout() async {
    if (storage.hasData('user')) {
      await storage.remove('user');
    }
    if (storage.hasData('token')) {
      await storage.remove('token');
    }
    token.value = null;
    authUser.value = null;
    await GoogleAuth.logOut();
    Get.offAndToNamed(HOME_PAGE);
  }

  createCommunity({required int sellerId, String? message}) async {

    if (createCommunityLodaing.value) {
      return;
    }
    if (sellerId == authUser.value?.id) {
      showToast(text: 'لا يمكنك بدء محادثة مع نفسك', type: 'error');
      return;
    }
    createCommunityLodaing.value = true;
    if (authUser.value == null) return;

    query.value = '''
   mutation CreateChat(\$memberId:Int!) {
    createChat(memberId:\$memberId ) {
      community{
        id
        name
        type
        url
        users_count
        last_update
        image
        created_at
        users {
            id
            name
            seller_name
            is_verified
            image
        }
        manager {
            id
        }
      }
      user{
      $AUTH_FIELDS}
    }
    
}
     ''';
    variables.value = {'memberId': sellerId};
    try {
      dio.Response? res = await fetchData();

      if (res?.data?['data']['createChat']['user'] != null) {
        var dataUser = res?.data?['data']['createChat']['user'];
        await setUserJson(json: res?.data?['data']['createChat']['user']);
      }
      if (res?.data?['data']?['createChat']?['community'] != null) {
        CommunityModel community = CommunityModel.fromJson(
            res?.data?['data']['createChat']['community']);
        pusher.value = null;

        communitySubscribe(
            'private-message.${community.id}.${authUser.value?.id}');
        Get.offAndToNamed(CHAT_PAGE,
            arguments: community,
            parameters: {"msg": message != null ? message : ''});
      }
    } catch (e) {
      logger.e("Error Create Community $e");
    }
    createCommunityLodaing.value = false;
  }

  getAdvices() async {
    query.value = '''
    query Advices {
  
      advices {
        name
        user {
            id
            name
            seller_name
        }
        url
        image
        id
    }
    
    settings {
        social {
            twitter
            face
            instagram
            youtube
            linkedin
            telegram
            name
            email
            sub_email
            phone
            sub_phone
        }
        
        address
        weather_api
        current_version
        force_upgrade
        advice_url
        active_advice
        delivery_service
        auto_update_exchange
        about
        privacy
        active_live
        live_id
        support{
          id
          name
        }
        delivery{
          id
          name
        }
    }
   
}
    ''';
    try {
      dio.Response? res = await fetchData();

      if (res?.data?['data']?['me'] != null) {
        setUserJson(json: res?.data?['data']['me']);
      }
      if (res?.data?['data']?['advices'] != null) {
        for (var item in res?.data?['data']['advices']) {
          advices.add(AdviceModel.fromJson(item));
        }
      }
      if (res?.data?['data']?['settings'] != null) {
        settings.value = SettingModel.fromJson(res?.data?['data']['settings']);
        if (settings.value.force_upgrade == true &&
            settings.value.current_version != versionAPK) {
          Get.dialog(
              AlertDialog(
                backgroundColor: WhiteColor,
                content: Container(
                  height: 0.4.sh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'يرجى تحديث التطبيق إلى النسخة ',
                                style: H3BlackTextStyle),
                            TextSpan(
                                text: ' ${settings.value.current_version}',
                                style: H3RedTextStyle),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'الإصدار الحالي ',
                                style: H3BlackTextStyle),
                            TextSpan(text: versionAPK, style: H3RedTextStyle),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          'حمل النسخة الجديدة من',
                          style: H2OrangeTextStyle,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.02.sh, horizontal: 0.02.sw),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                openUrl(
                                    url: "${settings.value.urlDownload?.play}");
                              },
                              borderRadius: BorderRadius.circular(30.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'متجر GOOGLE PLAY',
                                    style: H3RegularDark,
                                  ),
                                  const Icon(FontAwesomeIcons.googlePlay),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.02.sh, horizontal: 0.02.sw),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                openUrl(
                                    url: settings.value.urlDownload?.direct ??
                                        'https://ali-pasha.com/app');
                              },
                              borderRadius: BorderRadius.circular(30.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'تحميل مباشر APK',
                                    style: H3RegularDark,
                                  ),
                                  const Icon(FontAwesomeIcons.mobileScreen),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.02.sh, horizontal: 0.02.sw),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                openUrl(
                                    url:
                                        "${settings.value.urlDownload?.up_down}");
                              },
                              borderRadius: BorderRadius.circular(30.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'من موفع AppToDown',
                                    style: H3RegularDark,
                                  ),
                                  const Icon(FontAwesomeIcons.circleDown),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              barrierDismissible: false,
              name: 'upgrade');
        }
      }
    } catch (e) {
      logger.e("Error GetAdvices $e");
    }
  }

  getPricingData() async {
    pricing.clear();
    query('''
    query Pricing {
    pricing {
        weight
        size
        internal_price
        external_price
    }
     me {
        total_balance
    }
}
    ''');

    dio.Response? res = await fetchData();
    if (res?.data?['data']?['pricing'] != null) {
      for (var item in res?.data['data']['pricing']) {
        pricing.add(PricingModel.fromJson(item));
      }
    }
  }

  Future<XFile?> commpressImage(
      {required XFile? file, int? width, int? height}) async {
    if (file != null) {
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        file.path + '.webp',
        format: CompressFormat.webp,
        quality: 80,
        minHeight: height ?? 300,
        minWidth: width ?? 300,
        rotate: 0,
        numberOfRetries: 10,
      );

      if (compressedFile != null) {
        return XFile(compressedFile.path);
      }
      return null;
    }
    return null;
  }

  Future<void> pickImage(
      {required ImageSource imagSource,
      required Function(XFile? file, int? fileSize) onChange}) async {
    XFile? selected = await ImagePicker().pickImage(source: imagSource);
    if (selected != null) {
      XFile? response = await cropImage(selected);
      if (response != null) {
        File compressedFile = File(response.path);
        int fileSize = await compressedFile.length();
        onChange(response, fileSize);
      }
    }
  }

  Future<XFile?> cropImage(XFile file, {CropAspectRatio? ratio}) async {
    try {
      CroppedFile? cropped = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.png,
        sourcePath: file.path,
        maxWidth: 300,
        maxHeight: 300,
        compressQuality: 80,
        aspectRatio: ratio ?? const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'قص الصورة',
            cropStyle: CropStyle.rectangle,
            activeControlsWidgetColor: RedColor,
            backgroundColor: Colors.grey.withOpacity(0.4),
            toolbarColor: RedColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (cropped != null) {
        return await commpressImage(file: XFile(cropped.path));
      }
      return null;
    } catch (e) {
      return file;
    }
  }

  Future<void> addToCart({required ProductModel product}) async {
    cartLoading.value = true;
    try {
      List<CartModel> cartsItem = await CartHelper.addToCart(product: product);
      carts(cartsItem);
      //  messageBox(message: 'تم إضافة المنتج إلى السلة', title: 'نجاح العملية');
    } catch (e) {}
    cartLoading.value = false;
  }

  Future<void> removeBySeller({int? sellerId}) async {
    cartLoading.value = true;
    try {
      List<CartModel> cartsItem =
          await CartHelper.removeBySeller(sellerId: sellerId);
      carts(cartsItem);
    } catch (e) {}
    cartLoading.value = false;
  }

  Future<void> minFromCart({required ProductModel product}) async {
    cartLoading.value = true;
    try {
      List<CartModel> cartsItem =
          await CartHelper.minFromCart(product: product);
      carts(cartsItem);
    } catch (e) {}
    cartLoading.value = false;
  }

  Future<void> deleteFromCart({required ProductModel product}) async {
    cartLoading.value = true;
    try {
      logger.f(product.id);
      List<CartModel> cartsItem = await CartHelper.removeCart(product: product);
      carts(cartsItem);
    } catch (e) {}
    cartLoading.value = false;
  }

  refreshCart() async {
    carts.value = List.from(await CartHelper.getCart());
  }

  Future<void> emptyCart() async {
    cartLoading.value = true;
    try {
      List<CartModel> cartsItem = await CartHelper.emptyCart();
      carts(cartsItem);
    } catch (e) {}
    cartLoading.value = false;
  }

  Future<void> increaseQty({required int productId}) async {
    cartLoading.value = true;
    try {
      List<CartModel> cartsItem =
          await CartHelper.increaseQty(productId: productId);
      carts(cartsItem);
    } catch (e) {}
    cartLoading.value = false;
  }

  Future<void> decreaseQty({required int productId}) async {
    cartLoading.value = true;
    try {
      List<CartModel> cartsItem =
          await CartHelper.decreaseQty(productId: productId);
      carts(cartsItem);
    } catch (e) {}
    cartLoading.value = false;
  }

  bool isURL(String text) {
    /*final RegExp urlRegExp =
    RegExp(r'^(https?:\/\/)?' //  بدء الرابط بـ "http://" أو "https://"
    r'([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,}' // النطاق مثل "example.com"
    r'(:\d+)?(\/[^\s]*)?$' // اختياري: المنفذ والمسار
    );*/

    /*   final RegExp urlRegExp = RegExp(
        //  r'[\n ]'
        r'^(https?:\/\/)?' // يبدأ بـ "http://" أو "https://"
        r'([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}|' // نطاقات مثل .com, .org, .net وغيرها
        r'localhost|' // يسمح بـ localhost
        r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|' // يسمح بالعناوين IP
        r'\[[0-9a-fA-F:]+\])' // يسمح بالعناوين IPv6
        r'(:\d+)?' // المنفذ اختياري
        r'(\/[^\s]*)?$' // المسار يمكن أن يحتوي على أي حرف
        //   r'[\n ]'
        );*/

    final RegExp urlRegExp = RegExp(r'[ \n| ]' // يبدأ بـ \n أو مسافة
        r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+' // الرابط
        r'[ \n| ]' // ينتهي بـ \n أو مسافة
        );

    return urlRegExp.hasMatch(text) && !text.contains('@');
  }

// Mute Notify Community
  Future<CommunityModel?> muteCommunity({required int communityId}) async {
    query.value = '''
    mutation MuteCommunity {
    muteCommunity(communityId: "$communityId") {
        id
        name
        image
        type
        manager {
            id
            name
            seller_name
            image
            is_verified
        }
        type
        url
        users {
            id
            name
            seller_name
            is_verified
            image
        }
        users_count
        last_update
        image
        created_at
        pivot {
            is_manager
            notify
        }
    }
}

    ''';
    try {
      dio.Response? res = await fetchData();
      logger.d(res?.data?['data']?['muteCommunity']);
      if (res?.data?['data']?['muteCommunity'] != null) {
        return CommunityModel.fromJson(res?.data?['data']?['muteCommunity']);
      }
    } catch (e) {}
  }

// Get Auth Data
  Future<void> getMe() async {
    query.value = ''' query Me {
    me {$AUTH_FIELDS} }''';
    try {
      dio.Response? res = await fetchData();

      if (res?.data?['data']?['me'] != null) {
        pusher.value = null;
        await setUserJson(json: res?.data?['data']?['me']);

        OneSignal.login("${authUser.value?.id}");
        OneSignal.User.addEmail("${authUser.value?.email}");
      }
    } catch (e) {}
  }

// Check Status Maintenance App
  Future<bool> checkStatusApp() async {
    bool status = true;
    try {
      dio.Response res =
          await dio.Dio().get("https://status.pazarpasha.com/graph");
      logger.d('STATUS IS :');
      logger.d('${res.data}');
      status = res.data == null || res.data['status'] || res.statusCode != 200;
    } catch (e) {
      status = true;
    }
    return status;
  }

  follow({required int sellerId}) async {
    loading.value = true;
    try {
      query.value = '''
      mutation FollowAccount {
    followAccount(id: "$sellerId") {
       $AUTH_FIELDS
    }
}
      ''';
      dio.Response? res = await fetchData();
      //  mainController.logger.e(res?.data);
      if (res?.data?['data']?['followAccount'] != null) {
        setUserJson(json: res?.data?['data']?['followAccount']);
      }
    } on CustomException catch (e) {
      logger.e(e);
    }
    loading.value = false;
  }
}
