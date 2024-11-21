import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../Global/main_controller.dart';
import '../../models/invoice_model.dart';
import 'package:dio/dio.dart' as dio;

class InvoicesLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);

  RxList<InvoiceModel> invoices = RxList([]);
  MainController mainController = Get.find<MainController>();

  nextPage() {
    if (hasMorePage.value) {
      page++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getMyInvoices();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getMyInvoices();
  }

  getMyInvoices() async {
    loading.value = true;
    mainController.query.value = '''
    query SellerInvoice {
    sellerInvoice(first: 35, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            status
            created_at
            total
            shipping
            address
            phone
            user {
                name
                phone
                image
                city{
                name
                }
            }
            items {
                qty
                price
                total
                product {
                    name
                    image
                }
            }
        }
    }
}
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['sellerInvoice']['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['sellerInvoice']
            ['paginatorInfo']?['hasMorePages'];
      }
      if (res?.data?['data']?['sellerInvoice']['data'] != null) {
        for (var item in res?.data?['data']?['sellerInvoice']['data']) {
          invoices.add(InvoiceModel.fromJson(item));
        }
      }
    } catch (e) {}
    loading.value = false;
  }

  changeStatus(
      {required int invoiceId,
      required String status,
      String? msg = ''}) async {
    mainController.query.value='''
    mutation ChangeStatusInvoice {
    changeStatusInvoice(invoiceId: "$invoiceId}", status: "$status" , msg:"$msg") {
         id
            status
            created_at
            total
            shipping
            address
            phone
            user {
                name
                phone
                image
                city{
                name
                }
            }
            items {
                qty
                price
                total
                product {
                    name
                    image
                }
            }
    }
}

    ''';
    try{
      dio.Response? res = await mainController.fetchData();
      Logger().f(res?.data);
      if(res?.data?['data']?['changeStatusInvoice']!=null){
        int index=invoices.indexWhere((el)=>el.id==invoiceId);
        if(index>-1){
          invoices[index]=InvoiceModel.fromJson(res?.data?['data']?['changeStatusInvoice']);
        }
        mainController.showToast(text: 'تم تعديل حالة الطلب بنجاح');
      }
    }catch(e){

    }
  }
}
