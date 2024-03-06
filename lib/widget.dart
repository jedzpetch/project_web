import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/food_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Textformfields {
  static Widget fieldBlankWithIcon(String title, IconData icon,
      TextEditingController textEditingController, Color iconcolor) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 25.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Font.white16),
              TextFormField(
                  validator: (String? value) =>
                      value!.isEmpty ? "Please fill out information" : null,
                  onSaved: (value) => value!.isNotEmpty
                      ? textEditingController.text = value.trim()
                      : null,
                  controller: textEditingController,
                  scrollPadding: const EdgeInsets.all(1),
                  style: Font.black16B,
                  decoration: InputDecoration(
                    hintText: title,
                    filled: true,
                    fillColor: AppColor.platinum,
                    prefixIcon: Icon(icon,
                        color: iconcolor,
                        size: 35,
                        shadows: const [
                          Shadow(
                              color: AppColor.green,
                              offset: Offset(2, 2),
                              blurRadius: 1)
                        ]),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColor.platinum)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColor.platinum, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColor.platinum, width: 2)),
                  ))
            ]))
      ])
    ]);
  }

  static Widget fieldBlank(
      String title, TextEditingController textEditingController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 25.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Font.white16),
              TextFormField(
                  validator: (String? value) =>
                      value!.isEmpty ? "Please fill out information" : null,
                  onSaved: (value) => value!.isNotEmpty
                      ? textEditingController.text = value.trim()
                      : null,
                  controller: textEditingController,
                  scrollPadding: const EdgeInsets.all(1),
                  style: Font.black16B,
                  decoration: InputDecoration(
                    hintText: title,
                    filled: true,
                    fillColor: AppColor.platinum,
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColor.platinum)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColor.platinum, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColor.platinum, width: 2)),
                  ))
            ]))
      ])
    ]);
  }

  static Widget fieldPassWord(
      String title,
      IconData icon,
      bool obscure,
      Function function,
      TextEditingController textEditingController,
      bool showicon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 25.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("รหัสผ่าน", style: Font.white16),
                TextFormField(
                    onSaved: (value) => value!.isNotEmpty
                        ? textEditingController.text = value.trim()
                        : null,
                    controller: textEditingController,
                    scrollPadding: const EdgeInsets.all(5),
                    style: Font.black18B,
                    obscureText: obscure,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: title,
                      filled: true,
                      fillColor: AppColor.platinum,
                      prefixIcon: Icon(icon,
                          color: AppColor.orange,
                          size: 35,
                          shadows: const [
                            Shadow(offset: Offset(2, 2), color: AppColor.green)
                          ]),
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: showicon
                          ? IconButton(
                              onPressed: () => function(),
                              icon: obscure
                                  ? const Icon(Icons.visibility_off,
                                      color: AppColor.black)
                                  : const Icon(Icons.visibility,
                                      color: AppColor.orange,
                                      shadows: [
                                          Shadow(
                                              offset: Offset(1, 1),
                                              color: Colors.black)
                                        ]))
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: AppColor.platinum)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: AppColor.platinum, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: AppColor.platinum, width: 2)),
                    )),
              ],
            ))
      ])
    ]);
  }
}

class Button {
  static buttonSave(String label, var save) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Container(
        width: 250,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.green,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () => save(),
          child: Text(label,
              style: const TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class WidgetAll {
  static Widget dialog(IconData icon, String detail, Color iconcolor) {
    return Builder(builder: (context) {
      Future.delayed(const Duration(seconds: 1), () => Get.back());
      return AlertDialog(
          backgroundColor: AppColor.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Icon(icon, color: iconcolor, size: 50),
          content: Text(detail, style: Font.white18),
          actionsAlignment: MainAxisAlignment.center);
    });
  }

  static Widget loading() {
    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              LoadingAnimationWidget.threeRotatingDots(
                  color: AppColor.orange, size: 100),
              const Text("กำลังโหลด...", style: Font.white18B)
            ])));
  }

  static Widget addFood(
      String detail,
      Function function,
      String labelButtonok,
      String labelButtoncancel,
      TextEditingController nemeController,
      String titelTextformfield1,
      String titelTextformfield2,
      String titelTextformfield3,
      String titelTextformfield4,
      TextEditingController quantityController,
      TextEditingController calController,
      TextEditingController barcodeController,
      dynamic dropdownButton) {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 45.h,
            width: 55.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(detail, style: Font.white18B),
                const Spacer(),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(FontAwesomeIcons.xmark, color: Colors.red))
              ]),
              SizedBox(height: 2.h),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("หมวดหมู่อาหาร", style: Font.white16),
                          Container(
                              width: 10.w,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(children: [dropdownButton])),
                          SizedBox(height: 2.h),
                          Textformfields.fieldBlank(
                              titelTextformfield2, quantityController),
                          SizedBox(height: 2.h),
                          Textformfields.fieldBlank(
                              titelTextformfield4, barcodeController)
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textformfields.fieldBlank(
                              titelTextformfield1, nemeController),
                          SizedBox(height: 1.h),
                          Textformfields.fieldBlank(
                              titelTextformfield3, calController),
                          SizedBox(height: 6.h),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.orange),
                              onPressed: () => Get.dialog(addMaterial()),
                              child: const Text("เพิ่มส่วนประกอบของเมนู",
                                  style: Font.white20))
                        ]),
                  ])
            ])),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          ElevatedButton(
              onPressed: () => function(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
              child: Text(labelButtonok, style: Font.white18B))
        ]);
  }

  static Widget addMaterial() {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 62.5.h,
            width: 60.w,
            child: Column(children: [
              Row(children: [
                const Text("เพิ่มส่วนประกอบ", style: Font.white18B),
                const Spacer(),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(FontAwesomeIcons.xmark, color: Colors.red))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(children: [
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 1", FoodController.material1),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 2", FoodController.material2),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 3", FoodController.material3),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 4", FoodController.material4),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 5", FoodController.material5)
                ]),
                Column(children: [
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 6", FoodController.material6),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 7", FoodController.material7),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 8", FoodController.material8),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 9", FoodController.material9),
                  Textformfields.fieldBlank(
                      "ส่วนประกอบที่ 10", FoodController.material10)
                ])
              ])
            ])),
        actions: [
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
              child: const Text("บันทึก", style: Font.white18B))
        ]);
  }

  static Widget addExercisePoses(
      TextEditingController namecontroller,
      TextEditingController benefitcontroller,
      TextEditingController detailcontroller,
      TextEditingController setortimecontroller,
      TextEditingController caloriecontroller,
      dynamic funtionUploadimg,
      dynamic funtionVDO,
      RxString imageName,
      RxString vdoName,
      Function function) {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 62.5.h,
            width: 60.w,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("เพิ่มท่าออกกำลังกาย", style: Font.white18B),
                        const Spacer(),
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(FontAwesomeIcons.xmark,
                                color: Colors.red))
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textformfields.fieldBlank(
                                  "ท่าออกกำลังกาย", namecontroller),
                              SizedBox(height: 2.h),
                              Textformfields.fieldBlank(
                                  "จำนวนครั้งหรือระยะเวลา",
                                  setortimecontroller),
                              SizedBox(height: 2.h),
                              const Text("รายละเอียด", style: Font.white16),
                              SizedBox(
                                  height: 30.h,
                                  width: 25.w,
                                  child: TextFormField(
                                      maxLines: 6,
                                      onSaved: (value) => value!.isNotEmpty
                                          ? detailcontroller.text = value.trim()
                                          : null,
                                      controller: detailcontroller,
                                      scrollPadding: const EdgeInsets.all(1),
                                      style: Font.black16B,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          filled: true,
                                          fillColor: AppColor.platinum,
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: AppColor.platinum)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: AppColor.platinum,
                                                  width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(color: AppColor.platinum, width: 2)))))
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textformfields.fieldBlank(
                                  "ประโยชน์", benefitcontroller),
                              SizedBox(height: 2.h),
                              Textformfields.fieldBlank(
                                  "แคลอรี่", caloriecontroller),
                              SizedBox(height: 2.h),
                              const Text("รูปภาพ", style: Font.white16),
                              Container(
                                  height: 7.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Obx(() {
                                          return Text(imageName.value);
                                        }),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.orange),
                                            onPressed: () => funtionUploadimg(),
                                            child: const Text("เลือก",
                                                style: Font.black16)),
                                      ])),
                              SizedBox(height: 2.h),
                              const Text("วีดีโอ", style: Font.white16),
                              Container(
                                  height: 8.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Obx(() {
                                          return Text(vdoName.value);
                                        }),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.orange),
                                            onPressed: () => funtionVDO(),
                                            child: const Text("เลือก",
                                                style: Font.black16))
                                      ]))
                            ]),
                      ])
                ])),
        actions: [
          ElevatedButton(
              onPressed: () => function(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
              child: const Text("บันทึก", style: Font.white18B))
        ]);
  }
}
