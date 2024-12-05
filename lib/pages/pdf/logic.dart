
import 'package:get/get.dart';


class PdfLogic extends GetxController {
RxnString path=RxnString(Get.arguments);

RxBool loading=RxBool(false);
//Rxn<PDFDocument> document=Rxn(null);
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPdf();
  }

  getPdf()async{
   // document.value=await PDFDocument.fromURL("${path.value}");
  }
}
