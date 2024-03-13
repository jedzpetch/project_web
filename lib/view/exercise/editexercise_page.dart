import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/exercise_controller.dart';
import 'package:project_web/widget.dart';
import 'package:sizer/sizer.dart';

import '../../controller/home_controller.dart';

class EditExercisePage extends StatelessWidget {
  EditExercisePage({super.key});
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
                      child: const Text("อ่าน", style: Font.white18B)),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () {},
                      child: const Text("ลบข้อมูล",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
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
                          : const Center(
                              child: Text("ไม่มีข้อมูล"),
                            ))
                ]))
          ])
        ])));
  }

  Widget buildTableData() {
    return GetBuilder<ExerciseController>(builder: (controller) {
      List<PlutoColumn> columns = controller.columns;
      List<PlutoRow> rows = controller.rows;
      List<DataRow> dataRows = [];
      for (int i = 0; i < rows.length; i++) {
        List<DataCell> dataCells = [];
        for (int j = 0; j < columns.length; j++) {
          final PlutoCell cell =
              rows[i].cells[columns[j].field] ?? PlutoCell(value: '');
          if (j == columns.length - 1) {
            // เช็คว่าเป็น cell สุดท้ายหรือไม่
            dataCells.add(DataCell(TextButton(
                onPressed: () {
                  controller.deleteDataFromFirebase(i);
                },
                child: Text(cell.value, style: Font.red16))));
          } else {
            dataCells.add(DataCell(
              TextField(
                controller: TextEditingController(text: cell.value),
                onChanged: (value) {
                  controller.editCell(i, columns[j].field, value);
                },
              ),
              onDoubleTap: () {
                controller.viewDetail(cell.value, i, columns[j].field);
              },
            ));
          }
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
                    numeric: column.type == PlutoColumnType.number,
                  ))
              .toList(),
          rows: dataRows,
          headingRowHeight: 60,
          columnSpacing: 9.5.w,
        ),
      );
    });
  }
}
