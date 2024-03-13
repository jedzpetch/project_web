import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/exercise_controller.dart';
import 'package:project_web/controller/food_controller.dart';
import 'package:project_web/controller/home_controller.dart';
import 'package:project_web/model/user_model.dart';
import 'package:project_web/view/exercise/exercise_page.dart';
import 'package:project_web/view/food/food_page.dart';
import 'package:project_web/widget.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  final foodcontroller = Get.put(FoodController());
  final execisecontroller = Get.put(ExerciseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: Column(children: [
          Row(children: [
            Container(
                height: 100.h,
                width: 15.w,
                decoration: const BoxDecoration(color: AppColor.black),
                child: Column(children: [
                  SizedBox(height: 2.h),
                  Image.asset("lib/asset/image/iconApp.jpg", scale: 2),
                  const Spacer(),
                  InkWell(
                      child: Row(children: [
                    IconButton(
                        onPressed: () => controller.signout(),
                        icon: const Icon(Icons.logout, color: AppColor.orange)),
                    TextButton(
                        child: const Text("ออกจากระบบ", style: Font.white16),
                        onPressed: () => controller.signout())
                  ]))
                ])),
            Container(
                height: 100.h,
                width: 85.w,
                decoration: const BoxDecoration(color: AppColor.platinum),
                child: Column(children: [
                  Container(
                      height: 8.h,
                      decoration: const BoxDecoration(color: AppColor.white),
                      child: Row(children: [
                        SizedBox(width: 1.w),
                        const Text("หน้าหลัก", style: Font.black20B)
                      ])),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => listUser(controller.userData)),
                      Obx(() => dataFrame(
                              AppColor.black,
                              "ออกกำลังกาย",
                              Icons.fitness_center,
                              AppColor.black,
                              "จำนวนท่าออกกำลังกาย : ${controller.exerciseData.length}",
                              "เพิ่มท่าออกกำลังกาย",
                              "แก้ไขท่าออกกำลังกาย",
                              () => Get.to(() => ExercisePage()),
                              () => Get.dialog(WidgetAll.addExercisePoses(
                                  execisecontroller.namecontroller,
                                  execisecontroller.benefitcontroller,
                                  execisecontroller.detailcontroller,
                                  execisecontroller.setortimecontroller,
                                  execisecontroller.caloriecontroller,
                                  () => execisecontroller.uploadImage(),
                                  () => execisecontroller.uploadVideo(),
                                  execisecontroller.imagesName,
                                  execisecontroller.videoName,
                                  () => execisecontroller.addExercise())), () {
                            execisecontroller.changeMode();
                            Get.to(() => ExercisePage());
                          }))
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => dataFrame(
                              AppColor.black,
                              "อาหาร",
                              Icons.fastfood,
                              AppColor.orange,
                              "จำนวนอาหารทั้งหมด: ${controller.foodData.length}",
                              "เพิ่มเมนูอาหาร",
                              "แก้ไขเมนูอาหาร",
                              () => Get.to(() => const FoodPage()),
                              () => Get.dialog(WidgetAll.addFood(
                                  "เพิ่มเมนูอาหาร",
                                  () => foodcontroller.addFood(),
                                  "บันทึก",
                                  "ยกเลิก",
                                  foodcontroller.foodName,
                                  "เมนู",
                                  "ปริมาณ",
                                  "จำนวนแคลอรี่",
                                  "บาร์โค้ด",
                                  foodcontroller.foodQuantity,
                                  foodcontroller.foodCal,
                                  foodcontroller.foodBarcode,
                                  Obx(() => dropdown()))), () {
                            foodcontroller.changeMode();
                            Get.to(() => const FoodPage());
                          })),
                      Obx(() => showgoal())
                    ],
                  ),
                ]))
          ])
        ])));
  }

  Widget listUser(List<UserModel> list) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
                color: AppColor.black, borderRadius: BorderRadius.circular(20)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("ผู้ใช้งานแอปพลิเคชันทั้งหมด", style: Font.white),
                  Icon(FontAwesomeIcons.user,
                      size: 20.sp, color: AppColor.orange),
                  Text("${controller.userData.length}", style: Font.white20B),
                  const Text("คน", style: Font.white18)
                ])));
  }

  Widget showgoal() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
                color: AppColor.black, borderRadius: BorderRadius.circular(20)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("เป้าหมายทั้งหมด", style: Font.white),
                  Icon(Icons.flag, size: 20.sp, color: AppColor.orange),
                  Text("${controller.goalData.length}", style: Font.white20B),
                  const Text("เป้า", style: Font.white18)
                ])));
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
      dynamic addfunction,
      dynamic editfunction) {
    return InkWell(
      child: Container(
          height: 35.h,
          width: 45.w,
          decoration: BoxDecoration(
              color: backgroudcolor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Center(
                child: TextButton.icon(
                    label: Text(titel, style: Font.white20),
                    onPressed: () {},
                    icon: Icon(icon, color: iconcolor))),
            SizedBox(height: 3.h),
            Icon(icon, size: 20.sp, color: Colors.orange),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(toteltitel, style: Font.white18)),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.orange),
                  onPressed: () => addfunction(),
                  child: Text(add, style: Font.white16)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.orange),
                  onPressed: () {
                    editfunction();
                  },
                  child: Text(edit, style: Font.white16))
            ]),
            SizedBox(height: 2.h)
          ])),
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
              value: option, child: Text(option, style: Font.black16));
        }).toList(),
        onChanged: (value) {
          foodcontroller.changeCategory(value!);
        });
  }
}
