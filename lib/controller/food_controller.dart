import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/view/food/editfood_page.dart';
import 'package:project_web/view/food/food_page.dart';
import 'package:project_web/widget.dart';

class FoodController extends GetxController with StateMixin {
  RxBool selectAll = false.obs;
  final auth = FirebaseAuth.instance;
  var selectCategory = "อาหาร".obs;
  final textSearch = TextEditingController();
  final foodCal = TextEditingController();
  final foodName = TextEditingController();
  final foodBarcode = TextEditingController();
  final foodQuantity = TextEditingController();
  RxList<FoodModel> foodData = <FoodModel>[].obs;
  RxList<FoodModel> searchData = <FoodModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool editmode = false.obs;
  static final material1 = TextEditingController();
  static final material2 = TextEditingController();
  static final material3 = TextEditingController();
  static final material4 = TextEditingController();
  static final material5 = TextEditingController();
  static final material6 = TextEditingController();
  static final material7 = TextEditingController();
  static final material8 = TextEditingController();
  static final material9 = TextEditingController();
  static final material10 = TextEditingController();
  RxList docid = [].obs;

  final List<PlutoRow> rows = <PlutoRow>[].obs;
  final List<String> foodCategory = [
    "อาหาร",
    "เครื่องดื่ม",
    "ผลไม้",
    "ของทานเล่น"
  ];
  final List<PlutoColumn> columns = [
    PlutoColumn(
        title: "หมวดหมู่",
        field: "foodCategory",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "ชื่อ",
        field: 'foodName',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "ปริมาณ",
        field: 'foodQuantity',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "แคลอรี่",
        field: 'foodCal',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "บาร์โค้ด (ถ้ามี)",
        field: 'foodBarcode',
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

  void editRow(int rowIndex, Map<String, PlutoCell> newCells) {
    rows[rowIndex].cells.assignAll(newCells);
  }

  editCell(int rowIndex, String columnName, String? newValue) async {
    if (newValue != null) {
      final updatedCells = Map<String, PlutoCell>.from(rows[rowIndex].cells);
      updatedCells[columnName]!.value = newValue;
      editRow(rowIndex, updatedCells);

      Map<String, dynamic> data = {
        columnName: newValue,
      };

      await updateFirebaseData(data, rowIndex);
    } else {}
  }

  Future<void> deleteDataFromFirebase(int index) async {
    await FirebaseFirestore.instance
        .collection('FoodData')
        .doc(docid[index])
        .delete();
  }

  updateFirebaseData(Map<String, dynamic>? data, int index) async {
    if (data != null) {
      await FirebaseFirestore.instance
          .collection('FoodData')
          .doc(docid[index])
          .update(data);
    } else {}
  }

  changeMode() {
    editmode.value = !editmode.value;
    if (editmode.isTrue) {
      Get.to(() => const EditFoodPage());
    } else {
      Get.to(() => const FoodPage());
    }
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
    for (var doc in docs) {
      var id = doc.id;
      docid.add(id);
    }
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
    List<PlutoRow> updatedRows = searchData.isEmpty
        ? foodData.map((food) {
            return PlutoRow(
              cells: {
                'foodCategory': PlutoCell(value: food.foodCategory ?? ''),
                'foodName': PlutoCell(value: food.foodName ?? ''),
                'foodQuantity': PlutoCell(value: food.foodQuantity ?? ''),
                'foodCal': PlutoCell(value: food.foodCal ?? ''),
                'foodBarcode': PlutoCell(value: food.foodBarcode ?? ''),
              },
            );
          }).toList()
        : searchData.map((food) {
            return PlutoRow(
              cells: {
                'foodCategory': PlutoCell(value: food.foodCategory ?? ''),
                'foodName': PlutoCell(value: food.foodName ?? ''),
                'foodQuantity': PlutoCell(value: food.foodQuantity ?? ''),
                'foodCal': PlutoCell(value: food.foodCal ?? ''),
                'foodBarcode': PlutoCell(value: food.foodBarcode ?? '')
              },
            );
          }).toList();

    rows.assignAll(updatedRows);
    update();
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
