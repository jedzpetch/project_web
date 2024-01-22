import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/food_controller.dart';
import 'package:project_web/controller/home_controller.dart';
import 'package:project_web/view/food/food_page.dart';
import 'package:project_web/widget.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  final foodcontroller = Get.put(FoodController());
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
                        onTap: () => controller.signout(),
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
                              "Dashboard",
                              style: Font.black20B,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Obx(() => dataFrame(
                          AppColor.green,
                          "Food",
                          Icons.fastfood,
                          AppColor.orange,
                          "Total Menu : ${controller.foodData.length}",
                          "Add Menu",
                          "Edit Menu",
                          () => Get.to(() => FoodPage()),
                          () => Get.dialog(WidgetAll.addFood(
                              "Add Menu",
                              () => foodcontroller.addFood(),
                              "Save",
                              "Cancel",
                              foodcontroller.foodName,
                              "Menu Name",
                              "Quantity",
                              "Calorie",
                              "Barcode",
                              foodcontroller.foodQuantity,
                              foodcontroller.foodCal,
                              foodcontroller.foodBarcode,
                              Obx(
                                () => dropdown(),
                              ))))),
                      SizedBox(height: 5.h),
                      dataFrame(
                          AppColor.orange,
                          "Exercise",
                          Icons.fitness_center,
                          AppColor.green,
                          "Totel Exercise Positions : ",
                          "Add Exercise ",
                          "Edit Exercise ",
                          () {},
                          () {})
                    ],
                  ),
                )
              ],
            ),
          ],
        )));
  }

  Widget dataFrame(
      Color backgroudcolor,
      String titel,
      IconData icon,
      Color iconcolor,
      String toteltitel,
      String add,
      String edit,
      dynamic goto,
      dynamic addfunction) {
    return InkWell(
      child: Container(
        height: 20.h,
        width: 50.w,
        decoration: BoxDecoration(
            color: backgroudcolor, borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: TextButton.icon(
                label: Text(titel, style: Font.black20),
                onPressed: () {},
                icon: Icon(icon, color: iconcolor, shadows: const [
                  Shadow(offset: Offset(2, 2), color: AppColor.green)
                ])),
          ),
          SizedBox(height: 3.h),
          Text(
            toteltitel,
            style: Font.black18,
          ),
          SizedBox(height: 2.5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.platinum),
                  onPressed: () => addfunction(),
                  child: Text(
                    add,
                    style: Font.black16,
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.platinum),
                  onPressed: () {},
                  child: Text(
                    edit,
                    style: Font.black16,
                  ))
            ],
          )
        ]),
      ),
      onTap: () => goto(),
    );
  }

  dropdown() {
    return DropdownButton(
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(20),
      value: foodcontroller.selectCategory.value,
      items: foodcontroller.foodCategory.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(
            option,
            style: Font.black16,
          ),
        );
      }).toList(),
      onChanged: (value) {
        foodcontroller.changeCategory(value!);
      },
    );
  }
}
