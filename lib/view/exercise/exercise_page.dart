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
  ExercisePage({super.key});
  final homecontroller = Get.put(HomeController());
  final controller = Get.put(ExerciseController());
  @override
  Widget build(BuildContext context) {
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
                      child: const Text("หน้าแรก", style: Font.white18B)),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () => Get.dialog(WidgetAll.addExercisePoses(
                          controller.namecontroller,
                          controller.benefitcontroller,
                          controller.detailcontroller,
                          controller.setortimecontroller,
                          controller.caloriecontroller,
                          () => controller.uploadImage(),
                          () => controller.uploadVideo(),
                          controller.imagesName,
                          controller.videoName,
                          () => controller.addExercise())),
                      child: const Text("เพิ่มท่าออกกำลังกาย",
                          style: Font.white18B)),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () => controller.changeMode(),
                      child: const Text("แก้ไข", style: Font.white18B)),
                  const Spacer(),
                  InkWell(
                      child: const ListTile(
                          title: Text("ออกจากระบบ", style: Font.white16B),
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
                        const Text("ออกกำลังกาย", style: Font.black30B),
                        const Spacer(),
                        SizedBox(
                            height: 10.h,
                            width: 30.w,
                            child: Padding(
                                padding: EdgeInsets.all(2.h),
                                child: SearchBar(
                                  onChanged: (value) =>
                                      controller.search(value),
                                  hintText: 'ค้นหา...',
                                  leading: const Icon(
                                      FontAwesomeIcons.magnifyingGlass),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          AppColor.platinum),
                                  shadowColor: const MaterialStatePropertyAll(
                                      AppColor.black),
                                )))
                      ])),
                  Expanded(
                      child: controller.exercideData.isNotEmpty
                          ? buildTableData()
                          : const Center(child: Text("ไม่มีข้อมูล")))
                ]))
          ])
        ])));
  }

  Widget buildTableData() {
    return GetBuilder<ExerciseController>(builder: (exercisecontroller) {
      List<PlutoColumn> columns = exercisecontroller.columns;
      List<PlutoRow> rows = exercisecontroller.rows;
      List<DataRow> dataRows = [];
      for (int i = 0; i < rows.length; i++) {
        List<DataCell> dataCells = [];
        for (int j = 0; j < columns.length; j++) {
          final PlutoCell cell =
              rows[i].cells[columns[j].field] ?? PlutoCell(value: '');
          dataCells.add(DataCell(Text(cell.value.toString(),
              style: const TextStyle(color: Colors.black))));
        }
        dataRows.add(DataRow(cells: dataCells));
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: columns
              .map((column) => DataColumn(
                  label: Text(column.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  numeric: column.type == PlutoColumnType.number))
              .toList(),
          rows: dataRows,
          headingRowHeight: 60,
          columnSpacing: 1.w,
          dividerThickness: 1.5,
          border: TableBorder.all(width: 1.5, color: AppColor.black),
        ),
      );
    });
  }
}
