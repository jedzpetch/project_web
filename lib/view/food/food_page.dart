// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:project_web/widget.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/controller/food_controller.dart';
import 'package:project_web/controller/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore:
    final HomeController homeController = Get.put(HomeController());
    final FoodController foodController = Get.put(FoodController());
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: Column(children: [
          Row(children: [buildSidebar(), buildMainContent()])
        ])));
  }

  Widget buildSidebar() {
    final HomeController homeController = Get.find();
    final FoodController foodController = Get.find();
    return Container(
        height: 100.h,
        width: 20.w,
        decoration: const BoxDecoration(color: AppColor.black),
        child: Column(children: [
          SizedBox(height: 2.h),
          Image.asset("lib/asset/image/iconApp.jpg", scale: 2),
          SizedBox(height: 5.h),
          TextButton(
              onPressed: () => Get.back(),
              child: const Text("หน้าหลัก", style: Font.white18B)),
          SizedBox(height: 2.h),
          TextButton(
              onPressed: () => Get.dialog(addfood()),
              child: const Text("เพิ่มเมนูอาหาร", style: Font.white18B)),
          SizedBox(height: 2.h),
          TextButton(
              onPressed: () => foodController.changeMode(),
              child: const Text("แก้ไข", style: Font.white18B)),
          const Spacer(),
          InkWell(
              onTap: () => homeController.signout(),
              child: const ListTile(
                  title: Text("ออกจากระบบ", style: Font.white16B),
                  leading: Icon(FontAwesomeIcons.arrowRightFromBracket,
                      color: AppColor.orange)))
        ]));
  }

  Widget buildMainContent() {
    final FoodController foodController = Get.find();
    return Container(
        height: 100.h,
        width: 80.w,
        decoration: const BoxDecoration(color: AppColor.platinum),
        child: Column(children: [
          Container(
              height: 8.h,
              decoration: const BoxDecoration(color: AppColor.white),
              child: Row(children: [
                SizedBox(width: 1.w),
                const Text("อาหาร", style: Font.black30B),
                const Spacer(),
                SizedBox(
                    height: 10.h,
                    width: 30.w,
                    child: Padding(
                        padding: EdgeInsets.all(2.h),
                        child: SearchBar(
                            onChanged: (value) => foodController.search(value),
                            hintText: 'ค้นหา...',
                            leading:
                                const Icon(FontAwesomeIcons.magnifyingGlass),
                            backgroundColor: const MaterialStatePropertyAll(
                                AppColor.platinum),
                            shadowColor: const MaterialStatePropertyAll(
                                AppColor.black))))
              ])),
          SizedBox(height: 2.h),
          Expanded(child: buildTableData())
        ]));
  }

  Widget buildTableData() {
    return GetBuilder<FoodController>(builder: (foodController) {
      List<PlutoColumn> columns = foodController.columns;
      List<PlutoRow> rows = foodController.rows;
      List<DataRow> dataRows = [];
      for (int i = 0; i < rows.length; i++) {
        List<DataCell> dataCells = [];
        for (int j = 0; j < columns.length; j++) {
          dataCells.add(DataCell(Text(
            rows[i].cells[columns[j].field]?.value ?? '',
          )));
        }
        dataRows.add(DataRow(cells: dataCells));
      }
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              border: TableBorder.all(width: 1.5, color: AppColor.black),
              columns: columns
                  .map((column) => DataColumn(
                      label: Text(column.title, style: Font.black20B),
                      numeric: column.type == PlutoColumnType.number))
                  .toList(),
              rows: dataRows,
              headingRowHeight: 60,
              columnSpacing: 100));
    });
  }

  Widget addfood() {
    final FoodController foodController = Get.find();
    return WidgetAll.addFood(
        "เพิ่มเมนูอาหาร",
        () => foodController.addFood(),
        "บันทึก",
        "ยกเลิก",
        foodController.foodName,
        "ชื่อเมนู",
        "ปริมาณ",
        "แคลอรี่",
        "บาร์โค้ด (ถ้ามี)",
        foodController.foodQuantity,
        foodController.foodCal,
        foodController.foodBarcode,
        Obx(() => dropdown(foodController)));
  }

  Widget dropdown(FoodController foodController) {
    return DropdownButton(
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
        value: foodController.selectCategory.value,
        items: foodController.foodCategory.map((option) {
          return DropdownMenuItem(
              value: option, child: Text(option, style: Font.black16));
        }).toList(),
        onChanged: (value) => foodController.changeCategory(value!));
  }
}
