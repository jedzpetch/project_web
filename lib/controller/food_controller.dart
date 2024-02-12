import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/widget.dart';

class FoodController extends GetxController with StateMixin {
  RxBool selectAll = false.obs;
  final auth = FirebaseAuth.instance;
  var selectCategory = "01 อาหาร".obs;
  final textSearch = TextEditingController();
  final foodCal = TextEditingController();
  final foodName = TextEditingController();
  final foodBarcode = TextEditingController();
  final foodQuantity = TextEditingController();
  RxList<FoodModel> foodData = <FoodModel>[].obs;
  RxList<FoodModel> searchData = <FoodModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<PlutoRow> rows = <PlutoRow>[].obs;
  final List<String> foodCategory = [
    "01 อาหาร",
    "02 เครื่องดื่ม",
    "03 ผลไม้",
    "04 ของทานเล่น"
  ];
  final List<PlutoColumn> columns = [
    PlutoColumn(
        title: "Category",
        field: "category",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Name",
        field: 'name',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Quantity",
        field: 'quantity',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Calorie",
        field: 'calorie',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Barcode",
        field: 'barcode',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
  ].obs;

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

  void search(String query) {
    searchData.clear();
    for (var food in foodData) {
      if (food.foodName!.toLowerCase().contains(query.toLowerCase()) ||
          food.foodCategory!.toLowerCase().contains(query.toLowerCase())) {
        searchData.add(food);
        updateRows();
      }
    }
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
    updateRows();
  }

  void updateRows() async {
    rows.assignAll(searchData.isEmpty
        ? foodData.map((food) {
            return PlutoRow(
              cells: {
                'category': PlutoCell(value: food.foodCategory),
                'name': PlutoCell(value: food.foodName),
                'quantity': PlutoCell(value: food.foodQuantity),
                'calorie': PlutoCell(value: food.foodCal),
                'barcode': PlutoCell(value: food.foodBarcode)
              },
            );
          }).toList()
        : searchData.map((food) {
            return PlutoRow(
              cells: {
                'category': PlutoCell(value: food.foodCategory),
                'name': PlutoCell(value: food.foodName),
                'quantity': PlutoCell(value: food.foodQuantity),
                'calorie': PlutoCell(value: food.foodCal),
                'barcode': PlutoCell(value: food.foodBarcode)
              },
            );
          }).toList());
    update();
  }

  updateFirebaseData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('FoodData').doc().update(data);
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
      foodName.clear();
      foodQuantity.clear();
      foodCal.clear();
      foodBarcode.clear();
      getFoodData();
    } else {
      Get.dialog(
          WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
              "Data Not Empty", AppColor.orange),
          barrierDismissible: false);
    }
  }
}
