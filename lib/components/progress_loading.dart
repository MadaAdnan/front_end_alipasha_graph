import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressLoading extends StatelessWidget {
   ProgressLoading({super.key,this.width,this.height});
final double?width;
final double?height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child:  Lottie.asset('assets/json/loading.json'),
    );
  }
}
