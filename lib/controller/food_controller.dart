import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/widget.dart';

class FoodController extends GetxController with StateMixin {
  List foodData = [].obs;
  final foodName = TextEditingController();
  final foodQuantity = TextEditingController();
  final foodCal = TextEditingController();
  final foodBarcode = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectCategory = "01 ผลไม้".obs;
  final List<String> foodCategory = [
    "01 ผลไม้",
    "02 เนื้อสัตว์",
    "03 อาหารตามสั่ง",
    "04 ผลิตภัณฑ์ในร้านสะดวกซื้อ"
  ];

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    // getfoodData();
    change(null, status: RxStatus.success());
    super.onInit();
    update();
  }

  changeCategory(String value) {
    selectCategory.value = value;
  }

  getfoodData() async {
    await firestore.collection("FoodData").doc().get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      {
        foodData.add(FoodModel(
            foodName: data["foodName"],
            foodCategory: data["foodCategory"],
            foodQuantity: data["foodQuantity"],
            foodCal: data["foodCal"],
            foodBarcode: data["foodBarcode"]));
      }
      update();
    });
  }

  addFood() async {
    if (foodName.text.isNotEmpty &&
        foodQuantity.text.isNotEmpty &&
        foodCal.text.isNotEmpty &&
        foodBarcode.text.isNotEmpty) {
      await firestore.collection("FoodData").doc().set({
        "foodCategory": "",
        "foodName": foodName.text,
        "foodQuantity": foodQuantity.text,
        "foodCal": foodCal.text,
        "foodBarcode": foodBarcode.text,
      });
      Get.dialog(WidgetAll.dialog(
          FontAwesomeIcons.check, "Add Menu succeed", AppColor.green));
    } else {
      Get.dialog(
          WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
              "Data Not Empty", AppColor.orange),
          barrierDismissible: false);
    }
  }
}
