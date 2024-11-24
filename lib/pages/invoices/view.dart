import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/order_enum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/progress_loading.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../models/invoice_model.dart';
import 'logic.dart';

class InvoicesPage extends StatelessWidget {
  final logic = Get.put(InvoicesLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        shadowColor: WhiteColor,
        surfaceTintColor: WhiteColor,
        title: Text(
          'مبيعاتي',
          style: H2BlackTextStyle,
        ),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !logic.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }
          return true;
        },
        child: Obx(() {
          if (logic.invoices.length == 0 && logic.loading.value) {
            return Container(
              width: 1.sw,
              height: 1.sh,
              alignment: Alignment.center,
              child: ProgressLoading(
                width: 0.3.sw,
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
            children: [
              ...List.generate(logic.invoices.length, (index) {
                InvoiceModel invoice = logic.invoices[index];
                return InvoiceCard(invoice: invoice);
              }),
            ],
          );
        }),
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  InvoiceCard({required this.invoice});

  RxBool loading = RxBool(false);
  RxString selectedValue = RxString('البضاعة غير متوفرة');
  RxString message = RxString('البضاعة غير متوفرة');
  InvoicesLogic invoicesLogic = Get.find<InvoicesLogic>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.009.sh),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.4)),
                color: WhiteColor,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                      color: GrayLightColor,
                      spreadRadius: 0.2.r,
                      blurRadius: 0.7.r),
                  BoxShadow(
                      color: GrayLightColor,
                      spreadRadius: 0.2.r,
                      blurRadius: 0.7.r)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //header
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.007.sh, horizontal: 0.06.sw),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: GrayWhiteColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.15.sw,
                        height: 0.15.sw,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "${invoice.user?.image}"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${invoice.user?.name} ',
                                    style: H2BlackTextStyle.copyWith(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  TextSpan(
                                    text: ' (${invoice.user?.city?.name})',
                                    style: H5BlackTextStyle.copyWith(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.02.sw,
                            ),
                            if (invoice.phone != '')
                              InkWell(
                                onTap: () {
                                  openUrl(
                                      url: 'https://wa.me/${invoice.phone}');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                      size: 0.03.sw,
                                    ),
                                    SizedBox(
                                      width: 0.02.sw,
                                    ),
                                    Text(
                                      '${invoice.phone}',
                                      style: H2RegularDark,
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'ID :', style: H4RegularDark),
                                TextSpan(
                                    text: '${invoice.id}',
                                    style: H4RegularDark),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0.02.sw,
                          ),
                          Text(
                            '${invoice.created_at}',
                            style: H4RegularDark,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //addres
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.007.sh, horizontal: 0.06.sw),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: GrayWhiteColor))),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Text(
                            'ملاحظة : ',
                            style: H3RedTextStyle,
                          ),
                          Expanded(
                              child: Text(
                            'سيقوم فريق علي باشا بشحن البضاعة للزبون عند موافقتك على الطلب',
                            style: H4GrayTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                        ],
                      )),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.02.sw, horizontal: 0.02.sw),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150.r),
                              color: invoice.status?.getStatusOrderColor()),
                          child: Text(
                            "${invoice.status}".getStatusOrder(),
                            style: H4WhiteTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // items
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.001.sh, horizontal: 0.06.sw),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: GrayWhiteColor))),
                  child: Column(
                    children: [
                      ...List.generate(invoice.items?.length ?? 0, (i) {
                        ItemInvoice item = invoice.items![i];
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: GrayLightColor)),
                          ),
                          child: Row(
                            children: [
                              //image
                              Container(
                                width: 0.2.sw,
                                height: 0.2.sw,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "${item.product?.image}"),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              //data
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.product?.name}',
                                      style: H2BlackTextStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'عدد : ${item.qty}',
                                      style: H4RegularDark,
                                    ),
                                    Text(
                                      'سعر الوحدة :${item.price} \$',
                                      style: H2BlackTextStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
                //footer
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.007.sh, horizontal: 0.06.sw),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الإجمالي : ',
                            style: H2RegularDark,
                          ),
                          Text(
                            '${invoice.total} \$',
                            style:
                                H2BlackTextStyle.copyWith(color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0.007.sh,
                      ),
                      if (invoice.status == 'pending')
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                loading.value = true;
                                await invoicesLogic.changeStatus(
                                    invoiceId: invoice.id!, status: 'agree');
                                loading.value = false;
                              },
                              child: Container(
                                width: 0.4.sw,
                                height: 0.1.sw,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(150.r)),
                                alignment: Alignment.center,
                                child: Text(
                                  'قبول الطلب',
                                  style: H3WhiteTextStyle,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: cancelInvoice,
                              child: Container(
                                width: 0.4.sw,
                                height: 0.1.sw,
                                decoration: BoxDecoration(
                                    color: RedColor,
                                    borderRadius: BorderRadius.circular(150.r)),
                                alignment: Alignment.center,
                                child: Text(
                                  'إلغاء الطلب',
                                  style: H3WhiteTextStyle,
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (loading.value)
            Container(
              alignment: Alignment.center,
              width: 1.sw,
              height: 0.43.sh,
              child: ProgressLoading(
                width: 0.22.sw,
              ),
            )
        ],
      );
    });
  }

  cancelInvoice() {
    Get.dialog(AlertDialog(
      alignment: Alignment.center,
      content: Container(
        width: 1.sw,
        height: 0.5.sh,
        child: Obx(() {
          return ListView(
            children: [
              RadioMenuButton(
                value: 'البضاعة غير متوفرة',
                groupValue: selectedValue.value,
                onChanged: (value) {
                  selectedValue.value = value ?? '';
                  message.value = value ?? '';
                },
                toggleable: true,
                child: Text('البضاعة غير متوفرة', style: H3RegularDark),
              ),
              RadioMenuButton(
                value: 'المنتج مباع',
                groupValue: selectedValue.value,
                onChanged: (value) {
                  selectedValue.value = value ?? '';
                  message.value = value ?? '';
                },
                child: Text('المنتج مباع', style: H3RegularDark),
              ),
              RadioMenuButton(
                value: 'لا أرغب بإستخدام خدمة الشحن',
                groupValue: selectedValue.value,
                onChanged: (value) {
                  selectedValue.value = value ?? '';
                  message.value = value ?? '';
                },
                child:
                    Text('لا أرغب باستخدام خدمة الشحن', style: H3RegularDark),
              ),
              RadioMenuButton(
                value: 'other',
                groupValue: selectedValue.value,
                onChanged: (value) {
                  selectedValue.value = value ?? '';
                },
                child: Text('أخرى', style: H3RegularDark),
              ),
              if (selectedValue.value == 'other')
                Container(
                  child: TextField(
                    style: H4RegularDark,
                    maxLines: 3,
                    minLines: 2,
                    maxLength: 200,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value){
                      message.value=value??'';
                    },
                    decoration: InputDecoration(

                      label: Text(
                        'سبب الإلغاء',
                        style: H5GrayOpacityTextStyle,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: DarkColor),
                      ),
                    ),
                  ),
                ),

            ],
          );
        }),

      ),
      actions: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Obx(() {
             if(loading.value==false) {
               return InkWell(
                 onTap: () async {
                   loading.value = true;

                   await invoicesLogic.changeStatus(
                       invoiceId: invoice.id!, status: 'canceled',msg: message.value);
                   loading.value = false;
                   Get.back();
                 },
                 child: Container(
                   width: 0.3.sw,
                   height: 0.1.sw,
                   decoration: BoxDecoration(
                       color: Colors.green,
                       borderRadius: BorderRadius.circular(150.r)),
                   alignment: Alignment.center,
                   child: Text(
                     'متابعة',
                     style: H3WhiteTextStyle,
                   ),
                 ),
               );
             } else return  InkWell(
               child: Container(
                 width: 0.3.sw,
                 height: 0.1.sw,
                 decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(150.r)),
                 alignment: Alignment.center,
                 child: Text(
                   'جاري الإرسال ...',
                   style: H3WhiteTextStyle,
                 ),
               ),
             );
           }),
            InkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                width: 0.3.sw,
                height: 0.1.sw,
                decoration: BoxDecoration(
                    color: RedColor,
                    borderRadius: BorderRadius.circular(150.r)),
                alignment: Alignment.center,
                child: Text(
                  'إغلاق',
                  style: H3WhiteTextStyle,
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
