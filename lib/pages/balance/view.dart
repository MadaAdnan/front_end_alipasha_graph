

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BalancePage extends StatelessWidget {
  BalancePage({Key? key}) : super(key: key);

  final logic = Get.find<BalanceLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: [
                _buildHeader(title: 'إيداع'),
                _buildHeader(title: 'سحب'),
                _buildHeader(title: 'الرصيد'),
                _buildHeader(title: 'التاريخ'),
                _buildHeader(title: 'ملاحظات', width: 0.5.sw),
              ],
            ),
            Obx(() {
              if (logic.mainController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ...List.generate(
                          logic.balances.length,
                          (i) => Row(
                            children: [
                              _buildCell(
                                  title:
                                      '${logic.balances[i].credit?.toStringAsFixed(2)}',
                                  color: i % 2 == 0 ? null : GrayLightColor),
                              _buildCell(
                                  title:
                                      '${logic.balances[i].debit?.toStringAsFixed(2)}',
                                  color: i % 2 == 0 ? null : GrayLightColor),
                              _buildCell(
                                  title:
                                      '${logic.balances[i].total?.toStringAsFixed(2)}',
                                  color: i % 2 == 0 ? null : GrayLightColor),
                              _buildCell(
                                  title: '${logic.balances[i].createdAt}',
                                  color: i % 2 == 0 ? null : GrayLightColor),
                              _buildCell(
                                  title: '${logic.balances[i].info}',
                                  color: i % 2 == 0 ? null : GrayLightColor,
                                  width: 0.5.sw),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            })
          ],
        ),
      ),
    );
  }

  _buildHeader({String? title, double? width}) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 0.3.sw,
      height: 0.04.sh,
      decoration: BoxDecoration(
          color: GrayLightColor, border: Border.all(color: GrayDarkColor)),
      child: Text(
        '${title}',
        style: H2BlackTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildCell({String? title, Color? color, double? width}) {
    return Container(
      width: width ?? 0.3.sw,
      height: 0.04.sh,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: GrayDarkColor,
        ),
        color: color,
      ),
      child: Text(
        '${title}',
        style: H3BlackTextStyle,
      ),
    );
  }
}
