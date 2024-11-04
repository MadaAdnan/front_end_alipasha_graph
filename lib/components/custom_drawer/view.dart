import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';


class CustomDrawerComponent extends StatelessWidget {
  const CustomDrawerComponent({super.key});

  /*final logic = Get.find<CustomDrawerLogic>();
  final state = Get.find<CustomDrawerLogic>().state;*/

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(accountName: Text('Adnan',style: H1BlackTextStyle,), accountEmail: Text('adnan@gmail.com',style: H2GrayTextStyle,))
        ],
      ),
    );
  }
}
