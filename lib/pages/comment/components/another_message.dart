import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/components.dart';
import '../../../helpers/style.dart';
import '../../../models/comment_model.dart';

class AnotherMessage extends StatelessWidget {
  final CommentModel message;
  final logic;
  RxBool replay=RxBool(false);
  AnotherMessage({super.key, required this.message,required this.logic});
  TextEditingController messageController=TextEditingController();
MainController mainController=Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8.sw,
      margin: EdgeInsets.symmetric(vertical: 0.006.sh),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${message.user?.seller_name!.length != 0 ? message.user?.seller_name: message.user?.name}",
                style: H5OrangeTextStyle.copyWith(color: Colors.brown),
              ),
              Container(
                child: Container(
                  width: 0.09.sw,
                  height: 0.09.sw,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "${message.user?.image}"),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          Container(
            width: 0.7.sw,
            constraints: BoxConstraints(minWidth: 0.00001.sw),
            padding:
            EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.02.sw),
            margin: EdgeInsets.only(top: 0.005.sh),
            decoration: BoxDecoration(
                color: GrayLightColor,
                borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints:
                  BoxConstraints(minWidth: 0.001.sw, maxWidth: 0.7.sw),
                  child: RichText(
                    softWrap: true,
                    text: TextSpan(children: [
                      ..."${message.comment}".split(' ').map((el) {
                        if (mainController.isURL("$el")) {
                          return TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async => await openUrl(url: '$el'),
                            text: ' $el ',
                            style: H4RedTextStyle,
                          );
                        } else {
                          return TextSpan(text: ' $el ', style: H4RegularDark);
                        }
                      })
                    ]),
                  ),
                ),

                Container(
                  transformAlignment: Alignment.bottomLeft,
                  alignment: Alignment.bottomLeft,
                  child:Container(
                    transformAlignment: Alignment.bottomLeft,
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${message.createdAt}",
                          style: H4GrayTextStyle,
                        ),
                        GestureDetector(
                          onTap: (){
                            replay.value=true;
                          },
                          child: Text('رد',style: H3RegularDark,),
                        )
                      ],
                    ),
                  ),
                ),
                if (message.user?.id == mainController.authUser.value?.id || logic.product.value?.user?.id == mainController.authUser.value?.id)
                  GestureDetector(
                    onTap: () {
                      logic.deletComment(commentId: message.id!);
                    },
                    child: Container(
                      width: 0.7.sw,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'حذف',
                        style: H3RedTextStyle,
                      ),
                    ),
                  ),

              ],
            ),
          ),
          Obx(() {
            if(replay.value){
              return Container(
                width: 0.7.sw,
                height: 0.1.sh,
                child: Row(
                  children: [
                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r))
                      ),
                    ),
                    MaterialButton(onPressed: (){},child: Text('إرسال الرد'),)
                  ],
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
