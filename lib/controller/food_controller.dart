import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/widget.dart';

class FoodController extends GetxController with StateMixin {
  var foodData = <FoodModel>[].obs;
  final foodName = TextEditingController();
  final foodQuantity = TextEditingController();
  final foodCal = TextEditingController();
  final foodBarcode = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var selectCategory = "01 อาหาร".obs;
  final List<String> foodCategory = [
    "01 อาหาร",
    "02 เครื่องดื่ม",
    "03 ผลไม้",
    "04 ของทานเล่น"
  ];

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getFoodData();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  changeCategory(String value) {
    selectCategory.value = value;
  }

  Future<void> getFoodData() async {
    QuerySnapshot querySnapshot = await firestore.collection("FoodData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    foodData.assignAll(docs.map((data) {
      return FoodModel(
        foodName: data["foodName"],
        foodCategory: data["foodCategory"],
        foodQuantity: data["foodQuantity"],
        foodCal: data["foodCal"],
        foodBarcode: data["foodBarcode"],
      );
    }).toList());
  }

  addFood() async {
    if (foodName.text.isNotEmpty &&
        foodQuantity.text.isNotEmpty &&
        foodCal.text.isNotEmpty &&
        foodBarcode.text.isNotEmpty) {
      await firestore.collection("FoodData").doc().set({
        "foodCategory": selectCategory.value,
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
