
import 'package:ali_pasha_graph/components/progress_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'logic.dart';

class PdfPage extends StatelessWidget {
  final logic = Get.find<PdfLogic>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Container(
  child: SfPdfViewer.network('${logic.path}'),
),
    );
  }
}
