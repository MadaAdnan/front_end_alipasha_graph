import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSection extends StatelessWidget {
  // القيمة المختارة من الـ Radio
  String _sortOrder = "newest";

  // القيم المبدئية للـ Range
  RangeValues _priceRange = const RangeValues(100, 500);

  void _openFilterSheet() {
    showModalBottomSheet(
      context:Get.context as BuildContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder( // مهم عشان نقدر نعمل setState داخل الـ BottomSheet
          builder: (context, setStateSheet) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("الفلترة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),

                  // الاختيار بين الأحدث والأقدم
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("الأحدث"),
                          value: "newest",
                          groupValue: _sortOrder,
                          onChanged: (val) {
                            setStateSheet(() {
                              _sortOrder = val!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("الأقدم"),
                          value: "oldest",
                          groupValue: _sortOrder,
                          onChanged: (val) {
                            setStateSheet(() {
                              _sortOrder = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // اختيار المدى السعري
                  Text("نطاق السعر: ${_priceRange.start.round()} - ${_priceRange.end.round()}"),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    labels: RangeLabels(
                      _priceRange.start.round().toString(),
                      _priceRange.end.round().toString(),
                    ),
                    onChanged: (values) {
                      setStateSheet(() {
                        _priceRange = values;
                      });
                    },
                  ),

                  SizedBox(height: 20),

                  // زر التطبيق
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // إغلاق البوب أب
                      // هنا تقدر تستخدم القيم المحددة
                      print("الترتيب: $_sortOrder");
                      print("المدى السعري: ${_priceRange.start} - ${_priceRange.end}");
                    },
                    child: Text("تطبيق"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مثال الفلترة")),
      body: Center(
        child: ElevatedButton(
          onPressed: _openFilterSheet,
          child: Text("فتح الفلترة"),
        ),
      ),
    );
  }
}