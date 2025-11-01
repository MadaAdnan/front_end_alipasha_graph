import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../models/product_model.dart';

class HomeLogic extends GetxController {
  String getProductsQuery = '';
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> products = RxList([]);
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxList<UserModel> sellers = RxList<UserModel>([]);
  RxList<UserModel> nearSellers = RxList<UserModel>([]);
  RxList<UserModel> activitySeller = RxList<UserModel>([]);
  RxList<ProductModel> latest = RxList<ProductModel>([]);
  RxList<ProductModel> near = RxList<ProductModel>([]);
  RxList<ProductModel> videos = RxList<ProductModel>([]);
  RxList<ProductModel> activity = RxList<ProductModel>([]);
  RxList<ProductModel> specials = RxList<ProductModel>([]);
  RxInt page = RxInt(1);

  /// Global Key For Coach Mark
  GlobalKey loginKey = GlobalKey();
  GlobalKey catigoriesKey = GlobalKey();
  GlobalKey specialSellerKey = GlobalKey();
  GlobalKey jobKey = GlobalKey();
  GlobalKey homeKey = GlobalKey();
  GlobalKey serviceKey = GlobalKey();
  GlobalKey sectionKey = GlobalKey();
  GlobalKey tenderKey = GlobalKey();
  GlobalKey createProductKey = GlobalKey();
  GlobalKey whatsThink = GlobalKey();
  GlobalKey communityKey = GlobalKey();
  GlobalKey profileKey = GlobalKey();
  GlobalKey sellerKey = GlobalKey();
  GlobalKey moreCategoriesKey = GlobalKey();
  late List<TargetFocus> targetFoucos;
  Rxn<TutorialCoachMark> tutorialCoachMark = Rxn(null);
  final ScrollController scrollControllerCategories = ScrollController();

  @override
  void onInit() {
    super.onInit();
    initTarget();
    Future.delayed(Duration.zero, () async {
      await Future.delayed(const Duration(seconds: 4));
      if (scrollControllerCategories.hasClients) {
        await scrollControllerCategories.animateTo(
          50,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
        await scrollControllerCategories.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
        await scrollControllerCategories.animateTo(
          50,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
    getDataFromStorage();
    getSliderGroup();
    ever(
      page,
      (value) {
        getProduct();
      },
    );
  }

  initTarget() {
    targetFoucos = [
      TargetFocus(
        identify: "home",
        keyTarget: homeKey,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "🏠 الرئيسية \nشاهد منشورات مقترحة تناسب اهتماماتك، وتفاعل أو اطلب المنتج مباشرة من البائع.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "section",
        keyTarget: sectionKey,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "🛍 التصنيفات \nتصفّح منتجات التجار حسب التصنيف أو المدينة بسهولة.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "service",
        keyTarget: serviceKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "🧰 الخدمات \nاستعرض الدليل المهني مثل: نجّار، حدّاد، مهندس، وغيرهم.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "job",
        keyTarget: jobKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "💼 الوظائف \nتصفّح الوظائف المتاحة أو أضف إعلانك للبحث عن موظف.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      /*  TargetFocus(
        identify: "tender",
        keyTarget: tenderKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Text(
                "المناقصات",
                 style: H3WhiteTextStyle,
              ),
            ),
          ),
        ],
      ),*/
      TargetFocus(
        identify: "community",
        keyTarget: communityKey,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "💬 الدردشة\nتواصل مع المستخدمين أو انضم إلى المجموعات.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "profile2",
        keyTarget: profileKey,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "👤 الملف الشخصي \nأدر ملفك الشخصي، وتابع منشوراتك وحملاتك التسويقية.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      /* TargetFocus(
        identify: "profile",
        keyTarget: loginKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Text(
                "👤 الملف الشخصي \nأدر ملفك الشخصي، وتابع منشوراتك وحملاتك التسويقية.",
                style: H3WhiteTextStyle,
              ),
            ),
          ),
        ],
      ),*/
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "what",
        keyTarget: whatsThink,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "➕ نشر جديد\nانشر منتجًا أو وظيفة أو خدمة بخطوات بسيطة تصل لآلاف المستخدمين.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      /*TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "categories",
        keyTarget: catigoriesKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Text(
                "🛍 التصنيفات\nتصفّح منتجات التجار حسب التصنيف أو المدينة بسهولة.",
                style: H3WhiteTextStyle,
              ),
            ),
          ),
        ],
      ),*/
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "more-categories",
        keyTarget: moreCategoriesKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "📂 التصنيفات (التمرير)\nاسحب لليمين لعرض جميع التصنيفات.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      /* TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "seller",
        keyTarget: sellerKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Text(
                "متجر مميز",
                style: H3WhiteTextStyle,
              ),
            ),
          ),
        ],
      ),*/
      TargetFocus(
        identify: "createProduct",
        keyTarget: createProductKey,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "➕ نشر جديد\nانشر منتجًا أو وظيفة أو خدمة بخطوات بسيطة تصل لآلاف المستخدمين.",
                    style: H3WhiteTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.value!.next();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0.04.sh),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.001.sh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'التالي',
                              style: H3WhiteTextStyle,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }

  RxBool startTut = RxBool(false);

  startTutorialMode(BuildContext context) {
    bool isStart = mainController.storage.hasData('startTut');
    if (!isStart) {
      mainController.storage.write('startTut', true);
      Future.delayed(const Duration(seconds: 5), () {
        if (startTut.value == false) {
          tutorialCoachMark.value = TutorialCoachMark(
            targets: targetFoucos,
            skipWidget:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "تخطي",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ]),
          )..show(context: context);
          startTut.value = true;
        }
      });
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getProduct();
  }

  nextPage() {
    page.value++;
    // getProduct();
  }

  showDialogPrivacy() {}

  getProduct() async {
    loading.value = true;

    String dataString = '''data {
            id
            name
            weight
            expert
            type
            is_discount
            is_delivery
            is_available
            price
            views_count
            comments_count
            discount
            end_date
            type
            is_like
            likes_count
            level
            image
            video
            created_at
            user {
              id
              name
              id_color
              phone
              full_phone
              seller_name
              image
              logo
              is_verified
              city{
                id
                  name
                is_delivery
                code_city
                level  
              }
              area{
               id
               name
                is_delivery
                code_city
                level
               
              }
            }
          
            city {
            id
            name
               
            }
            start_date
              sub1 {
                name
            }
            category {
                name
            }
        }
        paginatorInfo {
            hasMorePages
        } ''';
    mainController.query('''
    query Products {
      SpecialProduct(first:3, page: ${page.value}) {
          $dataString
      }
      HobbiesProduct(first:12, page: ${page.value}) {
          $dataString
      }
       LatestProduct(first:15, page: ${page.value}) {
          $dataString
      }
   
   ${page.value == 1 ? r'''
    mainCategories{
        name
        color
        type
        has_color
        id
        image
      children{
        id
        name
        children{
          id
          name
          children{
            id
            name
         }
        }
      }
    }
    specialSeller{
      id
      name
      seller_name
      image
      custom
    }
    mainCity{
      id
      name
      is_delivery
      children{
       id
      name
      is_delivery
      code_city
      level
      }
    }
    
      colors{
      name
      id
    }
    
    
   ''' : ''}
   
  
}
    ''');

    try {
      dio.Response? res = await mainController.fetchData();

      loading.value = false;
      if (res?.data?['data']?['LatestProduct']?['paginatorInfo']
              ?['hasMorePages'] !=
          null) {
        hasMorePage(res?.data?['data']?['LatestProduct']?['paginatorInfo']
            ?['hasMorePages']);
      }
      if (res?.data?['data']?['LatestProduct']?['data'] != null) {
        if (page.value == 1) {
          products.clear();
        }
        for (var item in res?.data?['data']?['SpecialProduct']?['data']) {
          products.add(ProductModel.fromJson(item));
        }
        for (var item in res?.data?['data']?['HobbiesProduct']?['data']) {
          products.add(ProductModel.fromJson(item));
        }

        for (var item in res?.data?['data']?['LatestProduct']?['data']) {
          products.add(ProductModel.fromJson(item));
        }

        var productsList = [
          ...res?.data?['data']?['LatestProduct']?['data'] ?? [],
          ...res?.data?['data']?['HobbiesProduct']?['data'] ?? [],
          ...res?.data?['data']?['SpecialProduct']?['data'] ?? [],
        ];

        if (mainController.storage.hasData('products')) {
          mainController.storage.remove('products');
        }
        await mainController.storage.write('products', productsList);
      }

      if (res?.data['data']?['mainCategories'] != null) {
        if (page.value == 1) {
          mainController.categories.clear();
        }
        for (var item in res?.data['data']['mainCategories']) {
          mainController.categories.add(CategoryModel.fromJson(item));
        }
        mainController.storage
            .write('mainCategories', res?.data['data']['mainCategories']);
      }

      if (res?.data?['data']?['cities'] != null) {
        for (var item in res?.data['data']?['cities']) {
          mainController.cities.add(CityModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['mainCity'] != null) {
        for (var item in res?.data['data']?['mainCity']) {
          mainController.mainCities.add(CityModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['colors'] != null) {
        for (var item in res?.data['data']['colors']) {
          mainController.colors.add(ColorModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['specialSeller'] != null) {
        if (page.value == 1) {
          sellers.clear();
        }
        for (var item in res?.data?['data']?['specialSeller']) {
          sellers.add(UserModel.fromJson(item));
        }
        mainController.storage
            .write('specialSeller', res?.data?['data']?['specialSeller']);
      }
    } catch (e) {
      mainController.logger.w('ERRORPRO');
      mainController.logger.w('$e');
    }

    loading.value = false;
  }

  getSliderGroup() async {
    loading.value = true;

    String dataProduct = '''{
            id
            name
            weight
            expert
            type
            is_discount
            is_delivery
            is_available
            price
            views_count
            comments_count
            discount
            end_date
            type
            is_like
            likes_count
            level
            image
            video
            created_at
            user {
              id
              name
           
              phone
            
              seller_name
              image
              logo
              is_verified
            
           
            }
            city{
            name
            }
            category{
            name
            }
          
        }
        ''';
    String dataUser=''' {
     id
              name
              is_verified
              image
              seller_name
              address
    }''';
    mainController.query('''
    query Latest {
     latest $dataProduct
near $dataProduct
videos $dataProduct
activity $dataProduct
specials $dataProduct
      nearSellers $dataUser
      
}
    ''');

    try {
      dio.Response? res = await mainController.fetchData();
      loading.value = false;
      Logger().e(res?.data);
      if (res?.data?['data']?['latest'] != null) {
        for (var item in res?.data?['data']?['latest']) {
          latest.add(ProductModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['near'] != null) {
        for (var item in res?.data?['data']?['near']) {
          near.add(ProductModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['videos'] != null) {
        for (var item in res?.data?['data']?['videos']) {
          videos.add(ProductModel.fromJson(item));
        }
      }
      if (res?.data?['data']?['activity'] != null) {
        for (var item in res?.data?['data']?['activity']) {
          activity.add(ProductModel.fromJson(item));
        }
      }
      if (res?.data?['data']?['specials'] != null) {
        for (var item in res?.data?['data']?['specials']) {
          specials.add(ProductModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['nearSellers'] != null) {
        for (var item in res?.data?['data']?['nearSellers']) {
          nearSellers.add(UserModel.fromJson(item));
        }
      }
      if (res?.data?['data']?['activitySellers'] != null) {
        for (var item in res?.data?['data']?['activitySellers']) {
          activitySeller.add(UserModel.fromJson(item));
        }
      }

    } catch (e) {
      mainController.logger.w('ERRORPRO');
      mainController.logger.w('$e');
    }

    loading.value = false;
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('products') ?? [];
    var listCategories = mainController.storage.read('mainCategories') ?? [];
    var listSeller = mainController.storage.read('specialSeller') ?? [];
    for (var item in listProduct) {
      products.add(ProductModel.fromJson(item));
    }
    for (var item in listCategories) {
      mainController.categories.add(CategoryModel.fromJson(item));
    }
    for (var item in listSeller) {
      sellers.add(UserModel.fromJson(item));
    }
  }
}
