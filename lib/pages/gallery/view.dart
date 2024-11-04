import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/components.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);

  final logic = Get.find<GalleryLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
         return Visibility(child: Container(
           width: 0.4.sw,
           decoration: BoxDecoration(
               color: RedColor,
               borderRadius: BorderRadius.circular(30.r)
           ),
           child: IconButton(
             onPressed: () async {
               Get.defaultDialog(
                   title: 'رفع صورة إلى معرض الصور',
                   middleText: 'سيتم عرض الصورة في معرض الصور الخاص بك',
                   onConfirm: () {
                     mainController.pickImage(
                       imagSource: ImageSource.gallery,
                       onChange: (file, fileSize) async {
                         if (file != null) {
                           logic.imageGallaery.value = file;
                         }
                       },
                     );
                   });
             },
             icon: Row(
               children: [
                 Icon(FontAwesomeIcons.solidImages),
                 SizedBox(width: 0.01.sw,),
                 Text('إضافة إلى معرض الصور',style: H4WhiteTextStyle,),
               ],
             ),
             color: WhiteColor,
           ),
         ),visible: (mainController.authUser.value?.id == logic.seller.value?.id) && mainController.authUser.value?.is_verified==true,);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: WhiteColor,
      body: SingleChildScrollView(
        child: Obx(() {

          if (logic.loading.value) {
            return Container(
              width: 1.sw,
              height: 1.sh,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: 0.3.sw,
                child: ProgressLoading(),
              ),
            );
          }
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw, vertical: 0.005.sh),
                width: 1.sw,
                height: 0.06.sh,
                decoration: BoxDecoration(color: WhiteColor, boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                  )
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 0.05.sh,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.seller.value?.image}"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 0.02.sw,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'منشور بواسطة :',
                                  style: H4RegularDark,
                                ),
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 0.02.sh,
                                  color: GrayLightColor,
                                ),
                                Text(
                                  "${logic.seller.value?.city?.name}",
                                  style: H4RegularDark,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.02.sw,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${logic.seller.value?.seller_name}",
                                  style: H4BlackTextStyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black),
                                ),
                                if ((logic.seller.value?.is_verified == true))
                                  Container(
                                    width: 0.04.sw,
                                    height: 0.04.sw,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: Svg(
                                      "assets/images/svg/verified.svg",
                                      size: Size(0.01.sw, 0.01.sw),
                                    ))),
                                  ),
                              ],
                            )
                            //Text('${logic.product.value?.user?.seller_name}')
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        PopupMenuButton<String>(
                          color: WhiteColor,
                          iconColor: GrayDarkColor,
                          onSelected: (value) async {
                            switch (value) {
                              case '2':
                                if (mainController.settings.value.support?.id !=
                                    null) {
                                  mainController.createCommunity(
                                      sellerId: mainController
                                          .settings.value.support!.id!,
                                      message:
                                          ''' السلام عليكم ورحمة الله وبركاته 
                            إبلاغ  عن معرض الصور ${logic.seller.value?.seller_name} #${logic.seller.value?.id}''');
                                } else {
                                  openUrl(
                                      url:
                                          "https://wa.me/${mainController.settings.value.social?.phone}");
                                }

                                break;

                              default:
                                print('default');
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: '2',
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.ban,
                                    color: GrayDarkColor,
                                    size: 0.04.sw,
                                  ),
                                  SizedBox(
                                    width: 0.02.sw,
                                  ),
                                  Text(
                                    "إبلاغ عن المعرض",
                                    style: H3RegularDark,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 0.02.sw,
                  children: [
                    ...List.generate(logic.images.length, (index) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                          imageUrl:
                                              "${logic.images[index].url}",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                                    child: Image(
                                                      image: imageProvider,
                                                    ),
                                                  )),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: IconButton(
                                          icon: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: WhiteColor,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: DarkColor,
                                                      blurRadius: 0.02.sw)
                                                ]),
                                            child: const Icon(Icons.close,
                                                color: RedColor, size: 30),
                                          ),
                                          onPressed: () => Get.back(),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          color: Colors.black.withOpacity(0.7),
                                          child: Text(
                                            'index', // وصف الصورة
                                            style: H4BlackTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                             margin: EdgeInsets.symmetric(vertical: 0.02.sh,horizontal: 0.02.sw),
                              width: 0.4.sw,
                              height: 0.4.sw,
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 0.5.r,blurRadius: 0.1.r,blurStyle: BlurStyle.outer)],
                                borderRadius: BorderRadius.circular(30.r),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${logic.images[index].url}"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          if(mainController.authUser.value?.id == logic.seller.value?.id)
                          GestureDetector(
                            onTap: () {
                              logic.deleteMedia(logic.images[index].id!);
                            },
                            child: Container(
                              padding: EdgeInsets.all(0.01.sw),
                              decoration: BoxDecoration(
                                  color: WhiteColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: DarkColor,
                                        blurRadius: 0.1.r,
                                        spreadRadius: 0.05.r)
                                  ]),
                              child: Obx(() {
                                if (logic.deleteId.value ==
                                        logic.images[index].id &&
                                    logic.loadingDelete.value) {
                                  return CircularProgressIndicator();
                                }
                                return Icon(
                                  FontAwesomeIcons.trash,
                                  color: RedColor,
                                );
                              }),
                            ),
                          )
                        ],
                      );
                    }),
                  ],
                ),
              ),
              if(logic.loading.value==false && logic.images.length==0)
                Container(
                  child: Text('لا يوجد صور في المعرض',style: H3GrayTextStyle,),
                )
            ],
          );
        }),
      ),
    );
  }
}
