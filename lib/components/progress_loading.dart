import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ProgressLoading extends StatelessWidget {
   ProgressLoading({super.key,this.width,this.height});
final double?width;
final double?height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?? 0.3.sw,
      height: height??0.3.sw,
      child:  Lottie.asset('assets/json/loading.json'),
    );
  }
}
