import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TendersPage extends StatelessWidget {
  TendersPage({Key? key}) : super(key: key);

  final logic = Get.find<TendersLogic>();
  final state = Get.find<TendersLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
