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
    final HomeController homeController = Get.put(HomeController());
    final FoodController foodController = Get.put(FoodController());
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
                      onPressed: () => Get.dialog(addfood()),
                      child: const Text("Add Menu", style: Font.white18B)),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () => foodController.changeMode(),
                      child: Obx(() => Text(
                          foodController.editmode.isTrue
                              ? "view mode"
                              : "edit mode",
                          style: Font.white18B))),
                  const Spacer(),
                  InkWell(
                      child: const ListTile(
                          title: Text("Signout", style: Font.white16B),
                          leading: Icon(FontAwesomeIcons.arrowRightFromBracket,
                              color: AppColor.orange)),
                      onTap: () => homeController.signout())
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
                        const Text("Food", style: Font.black30B),
                        const Spacer(),
                        SizedBox(
                            height: 10.h,
                            width: 30.w,
                            child: Padding(
                                padding: EdgeInsets.all(2.h),
                                child: SearchBar(
                                  onChanged: (value) =>
                                      foodController.search(value),
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

  Widget addfood() {
    final FoodController foodController = Get.find();
    return WidgetAll.addFood(
      "Add Menu",
      () => foodController.addFood(),
      "Save",
      "Cancel",
      foodController.foodName,
      "Menu Name",
      "Quantity",
      "Calorie",
      "Barcode",
      foodController.foodQuantity,
      foodController.foodCal,
      foodController.foodBarcode,
      Obx(() => dropdown(foodController)),
    );
  }

  dropdown(FoodController foodController) {
    return DropdownButton(
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
        value: foodController.selectCategory.value,
        items: foodController.foodCategory.map((option) {
          return DropdownMenuItem(
              value: option, child: Text(option, style: Font.black16));
        }).toList(),
        onChanged: (value) {
          foodController.changeCategory(value!);
        });
  }

  Widget tabledata() {
    return GetBuilder<FoodController>(builder: (foodController) {
      List<PlutoColumn> columns = foodController.columns;
      List<PlutoRow> rows = foodController.rows;
      final FocusNode gridFocusNode = FocusNode();
      PlutoGridStateManager stateManager = PlutoGridStateManager(
          columns: columns,
          rows: rows,
          gridFocusNode: gridFocusNode,
          scroll: PlutoGridScrollController());
      for (int i = 0; i < rows.length; i++) {
        List<PlutoCell> rowCells = [];
        for (int j = 0; j < columns.length; j++) {
          PlutoCell cell =
              PlutoCell(value: rows[i].cells[columns[j].field]?.value ?? '');
          rowCells.add(cell);
        }
      }
      return Obx(() => PlutoGrid(
          columns: columns,
          rows: rows,
          onChanged: (event) {
            stateManager;
          },
          mode: foodController.editmode.value == true
              ? PlutoGridMode.normal
              : PlutoGridMode.readOnly,
          noRowsWidget: Center(child: WidgetAll.loading()),
          configuration: const PlutoGridConfiguration(
              columnSize: PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale))));
    });
  }
}
