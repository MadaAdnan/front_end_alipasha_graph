import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class NewDetailsPage extends StatelessWidget {
  final logic = Get.put(NewDetailsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
