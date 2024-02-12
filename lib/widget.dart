import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:sizer/sizer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Textformfields {
  static Widget fieldBlank(String title, IconData icon,
      TextEditingController textEditingController, Color iconcolor) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 35.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            width: 35.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password", style: Font.white16),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(icon, color: iconcolor, size: 50),
        content: Text(detail, style: Font.white18),
        actionsAlignment: MainAxisAlignment.center,
      );
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
              const Text("loading...", style: Font.white18B)
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
            height: 50.h,
            width: 80.w,
            child: Column(children: [
              Row(
                children: [
                  Text(detail, style: Font.white18B),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.red,
                      ))
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 2.h),
                const Text("Category", style: Font.white16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 15.w,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [dropdownButton])),
                      Textformfields.fieldBlank(titelTextformfield1,
                          FontAwesomeIcons.a, nemeController, AppColor.orange)
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Textformfields.fieldBlank(
                          titelTextformfield2,
                          FontAwesomeIcons.b,
                          quantityController,
                          AppColor.orange),
                      Textformfields.fieldBlank(titelTextformfield3,
                          FontAwesomeIcons.c, calController, AppColor.orange)
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Textformfields.fieldBlank(
                          titelTextformfield4,
                          FontAwesomeIcons.barcode,
                          barcodeController,
                          AppColor.orange)
                    ])
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

  static Widget addExercisePoses(
      TextEditingController namecontroller,
      TextEditingController benefitcontroller,
      TextEditingController detailcontroller,
      TextEditingController setortimecontroller,
      TextEditingController caloriecontroller,
      IconData icon,
      Color iconcolor,
      dynamic funtionUploadimg,
      dynamic funtionVDO,
      RxString imageName,
      RxString vdoName,
      Function function) {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 80.h,
            width: 80.w,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Add Exercise Poses", style: Font.white18B),
                      const Spacer(),
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            FontAwesomeIcons.xmark,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Textformfields.fieldBlank("Pose", FontAwesomeIcons.a,
                            namecontroller, AppColor.orange),
                        Textformfields.fieldBlank(
                            "benefits",
                            FontAwesomeIcons.b,
                            benefitcontroller,
                            AppColor.orange)
                      ]),
                  SizedBox(height: 2.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Textformfields.fieldBlank(
                            "Set or Time",
                            FontAwesomeIcons.c,
                            setortimecontroller,
                            AppColor.orange),
                        Textformfields.fieldBlank("Calorie", FontAwesomeIcons.d,
                            caloriecontroller, AppColor.orange)
                      ]),
                  SizedBox(height: 2.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Detail", style: Font.white16),
                              SizedBox(
                                  height: 30.h,
                                  width: 30.w,
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
                                          hintText: "Detail",
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
                                              borderSide: const BorderSide(color: AppColor.platinum, width: 2)),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: AppColor.platinum, width: 2)))))
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Image", style: Font.white16),
                              Container(
                                  height: 8.h,
                                  width: 35.w,
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
                                            child: const Text("Select",
                                                style: Font.black16))
                                      ])),
                              SizedBox(height: 5.h),
                              const Text("Video", style: Font.white16),
                              Container(
                                  height: 8.h,
                                  width: 35.w,
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
                                            child: const Text("Select",
                                                style: Font.black16))
                                      ])),
                            ])
                      ])
                ])),
        actions: [
          ElevatedButton(
              onPressed: () => function(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
              child: const Text("save", style: Font.white18B))
        ]);
  }
}
