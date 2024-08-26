import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/slider_model.dart';

class SliderComponent extends StatelessWidget {
  SliderComponent({Key? key, required this.items}) : super(key: key);

  final List<SliderModel> items;
  RxInt currentPage = RxInt(0);
  PageController pageController = PageController(initialPage: 0,);

  @override
  Widget build(BuildContext context) {
    startTimer();
    return WillPopScope(child: Container(
      width: 1.sw,
      height: 0.5.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r)
      ),
      child: PageView(
        controller: pageController,
        onPageChanged: (index) {
          currentPage.value = index;
        },
        children: [
          ...List.generate(
              items.length,
                  (index) => Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r)
                    ),
                child: CachedNetworkImage(
                  imageUrl: "${items[index].image}",
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    ), onWillPop: (){
      return Future.value(true);
    });
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 3), () {

      if (currentPage.value < items.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
      try{
        pageController.animateToPage(
          currentPage.value,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        startTimer();
      }catch(e){}

    });
  }

}
