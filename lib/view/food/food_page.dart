import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/food_controller.dart';
import 'package:project_web/controller/home_controller.dart';
import 'package:project_web/widget.dart';
import 'package:sizer/sizer.dart';

class FoodPage extends StatelessWidget {
  FoodPage({super.key});
  final homecontroller = Get.put(HomeController());
  final controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 100.h,
                  width: 20.w,
                  decoration: const BoxDecoration(color: AppColor.black),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Image.asset(
                        "lib/asset/image/iconApp.jpg",
                        scale: 2,
                      ),
                      SizedBox(height: 5.h),
                      TextButton(
                          onPressed: () => Get.dialog(WidgetAll.addFood(
                              "Add Menu",
                              () {},
                              "done",
                              controller.foodName,
                              "Menu Name",
                              "Quantity",
                              "Calorie",
                              "Barcode",
                              controller.foodQuantity,
                              controller.foodCal,
                              controller.foodBarcode,
                              Obx(() => DropdownButton(
                                    dropdownColor: AppColor.black,
                                    value: controller.selectCategory.value,
                                    items:
                                        controller.foodCategory.map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(
                                          option,
                                          style: Font.white16,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.changeCategory(value!);
                                    },
                                  )))),
                          child: const Text(
                            "Add Menu",
                            style: Font.white18,
                          )),
                      const Spacer(),
                      InkWell(
                        child: const ListTile(
                          title: Text(
                            "Signout",
                            style: Font.white16B,
                          ),
                          leading: Icon(
                            FontAwesomeIcons.arrowRightFromBracket,
                            color: AppColor.orange,
                          ),
                        ),
                        onTap: () => homecontroller.signout(),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100.h,
                  width: 80.w,
                  decoration: const BoxDecoration(color: AppColor.platinum),
                  child: Column(
                    children: [
                      Container(
                        height: 8.h,
                        decoration: const BoxDecoration(color: AppColor.white),
                        child: Row(
                          children: [
                            SizedBox(width: 1.w),
                            const Text(
                              "Food",
                              style: Font.black20B,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                )
              ],
            ),
          ],
        )));
  }

  dropdown() {
    return DropdownButton(
      value: controller.selectCategory.value,
      items: controller.foodCategory.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        controller.changeCategory(value!);
      },
    );
  }
}
