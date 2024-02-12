import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/exercise_controller.dart';
import 'package:project_web/controller/home_controller.dart';
import 'package:project_web/widget.dart';
import 'package:sizer/sizer.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});
  @override
  Widget build(BuildContext context) {
    final homecontroller = Get.put(HomeController());
    final controller = Get.put(ExerciseController());
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: Column(children: [
          Row(children: [
            Container(
                height: 100.h,
                width: 20.w,
                decoration: const BoxDecoration(color: AppColor.black),
                child: Column(children: [
                  SizedBox(height: 2.h),
                  Image.asset("lib/asset/image/iconApp.jpg", scale: 2),
                  SizedBox(height: 5.h),
                  TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Dashboard", style: Font.white18B)),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () => Get.dialog(WidgetAll.addExercisePoses(
                          controller.namecontroller,
                          controller.benefitcontroller,
                          controller.detailcontroller,
                          controller.setortimecontroller,
                          controller.caloriecontroller,
                          FontAwesomeIcons.f,
                          AppColor.orange,
                          () => controller.uploadImage(),
                          () => controller.uploadVideo(),
                          controller.imagesName,
                          controller.videoName,
                          () => controller.addExercise())),
                      child: const Text("Add Exercise", style: Font.white18B)),
                  const Spacer(),
                  InkWell(
                      child: const ListTile(
                          title: Text("Signout", style: Font.white16B),
                          leading: Icon(FontAwesomeIcons.arrowRightFromBracket,
                              color: AppColor.orange)),
                      onTap: () => homecontroller.signout())
                ])),
            Container(
                height: 100.h,
                width: 80.w,
                decoration: const BoxDecoration(color: AppColor.platinum),
                child: Column(children: [
                  Container(
                      height: 8.h,
                      decoration: const BoxDecoration(color: AppColor.white),
                      child: Row(children: [
                        SizedBox(width: 1.w),
                        const Text("Exercise", style: Font.black30B),
                        const Spacer(),
                        SizedBox(
                            height: 10.h,
                            width: 30.w,
                            child: Padding(
                                padding: EdgeInsets.all(2.h),
                                child: SearchBar(
                                  onChanged: (value) =>
                                      controller.search(value),
                                  hintText: 'Search...',
                                  leading: const Icon(
                                      FontAwesomeIcons.magnifyingGlass),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          AppColor.platinum),
                                  shadowColor: const MaterialStatePropertyAll(
                                      AppColor.black),
                                ))),
                      ])),
                  Expanded(child: tabledata())
                ]))
          ])
        ])));
  }

  Widget tabledata() {
    return GetBuilder<ExerciseController>(builder: (exerciseController) {
      return PlutoGrid(
          columns: exerciseController.columns,
          rows: exerciseController.rows,
          mode: PlutoGridMode.normal,
          noRowsWidget: Center(child: WidgetAll.loading()),
          configuration: const PlutoGridConfiguration(
              style: PlutoGridStyleConfig(),
              columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.scale,
              )));
    });
  }
}
