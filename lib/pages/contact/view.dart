import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final logic = Get.find<ContactLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Obx(() {
        if (logic.loading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: [
            Container(
              width: 1.sw,
              height: 0.07.sh,
              alignment: Alignment.center,
              child: Text(
                'معرفات التواصل',
                style: H2OrangeTextStyle,
              ),
            ),
            if(logic.social.value?.face != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: '${logic.social.value?.face}');
                  },
                  title: Text('${logic.social.value?.face}',style: H2GrayTextStyle,),
                  leading: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.twitter != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: '${logic.social.value?.twitter}');
                  },
                  title: Text('${logic.social.value?.twitter}',style: H2GrayTextStyle,),
                  leading: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.instagram != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: '${logic.social.value?.instagram}');
                  },
                  title: Text('${logic.social.value?.instagram}',style: H2GrayTextStyle,),
                  leading: Icon(
                    FontAwesomeIcons.instagram,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.linkedin != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: '${logic.social.value?.linkedin}');
                  },
                  title: Text('${logic.social.value?.linkedin}',style: H2GrayTextStyle,),
                  leading: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.telegram != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: '${logic.social.value?.telegram}');
                  },
                  title: Text('${logic.social.value?.telegram}',style: H2GrayTextStyle,),
                  leading: Icon(
                    FontAwesomeIcons.telegram,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.phone != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: 'https://wa.me/${logic.social.value?.phone}');
                  },
                  title: Text('${logic.social.value?.phone}',style: H2GrayTextStyle,),
                  subtitle: Text(
                    'رقم أساسي',
                    style: H5GrayTextStyle,
                  ),
                  leading: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.sub_phone != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(
                        url: 'https://wa.me/${logic.social.value?.sub_phone}');
                  },
                  title: Text('${logic.social.value?.sub_phone}',style: H2GrayTextStyle,),
                  subtitle: Text(
                    'رقم ثانوي',
                    style: H5GrayTextStyle,
                  ),
                  leading: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.email != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: 'mailto:${logic.social.value?.email}');
                  },
                  title: Text('${logic.social.value?.email}',style: H2GrayTextStyle,),
                  subtitle: Text(
                    'بريد أساسي',
                    style: H5GrayTextStyle,
                  ),
                  leading: Icon(
                    FontAwesomeIcons.envelope,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            if(logic.social.value?.sub_email != null)
            Card(
              color: WhiteColor,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    openUrl(url: 'mailto:${logic.social.value?.sub_email}');
                  },
                  title: Text('${logic.social.value?.sub_email}',style: H2GrayTextStyle,),
                  subtitle: Text(
                    'بريد ثانوي',
                    style: H5GrayTextStyle,
                  ),
                  leading: Icon(
                    FontAwesomeIcons.envelope,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
