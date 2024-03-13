import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/model/exercise_model.dart';
import 'package:project_web/view/exercise/editexercise_page.dart';
import 'package:project_web/view/exercise/exercise_page.dart';
import 'package:project_web/widget.dart';

class ExerciseController extends GetxController with StateMixin {
  var exercideData = <ExerciseModel>[].obs;
  RxList<ExerciseModel> searchData = <ExerciseModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final namecontroller = TextEditingController();
  final detailcontroller = TextEditingController();
  final caloriecontroller = TextEditingController();
  final benefitcontroller = TextEditingController();
  final setortimecontroller = TextEditingController();
  RxString imagesName = RxString("อัพโหลดรูปภาพ");
  RxString videoName = RxString("อัพโหลดวีดีโอ");
  String? imgUrl;
  String? vdoUrl;
  final List<PlutoRow> rows = <PlutoRow>[].obs;
  final List<PlutoColumn> columns = [
    PlutoColumn(
        title: "ชื่อ",
        field: "nameExercise",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "ประโยชน์",
        field: "benefitsExercise",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "ระยะเวลา / จำนวน",
        field: "setORtimeExercise",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "แคลอรี่",
        field: "calExercise",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "ลบ",
        field: "deleteIcon",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
  ].obs;
  RxBool editmode = false.obs;
  RxList docid = [].obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getExerciseData();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  changeMode() {
    editmode.value = !editmode.value;
    if (editmode.isTrue) {
      Get.to(() => (ExercisePage()));
    } else {
      Get.to(() => EditExercisePage());
    }
  }

  void viewDetail(String cellValue, int rowIndex, String columnName) {
    detailExercise(cellValue, rowIndex, columnName);
  }

  detailExercise(String cellValue, int rowIndex, String columnName) async {
    if (exercideData.isNotEmpty) {
      final cells = Map<String, PlutoCell>.from(rows[rowIndex].cells);
      namecontroller.text = cells["nameExercise"]!.value;
      benefitcontroller.text = cells["benefitsExercise"]!.value;
      detailcontroller.text = cells["detailExercise"]!.value;
      setortimecontroller.text = cells["setORtimeExercise"]!.value;
      caloriecontroller.text = cells["calExercise"]!.value;
      Get.dialog(WidgetAll.addExercisePoses(
          namecontroller,
          benefitcontroller,
          detailcontroller,
          setortimecontroller,
          caloriecontroller,
          () => uploadImage(),
          () => uploadVideo(),
          imagesName,
          videoName,
          () => updateDataForDetail(rowIndex)));
    }
  }

  updateDataForDetail(int index) async {
    if (namecontroller.text.isNotEmpty &&
        detailcontroller.text.isNotEmpty &&
        caloriecontroller.text.isNotEmpty &&
        benefitcontroller.text.isNotEmpty &&
        setortimecontroller.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('ExerciseData')
          .doc(docid[index])
          .update({
        'nameExercise': namecontroller.text,
        'detailExercise': detailcontroller.text,
        'calExercise': caloriecontroller.text,
        'benefitsExercise': benefitcontroller.text,
        'setORtimeExercise': setortimecontroller.text,
      });
      await getExerciseData();
      update();
    }
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

      await updateData(data, rowIndex);
    } else {}
  }

  Future<void> deleteDataFromFirebase(int index) async {
    await FirebaseFirestore.instance
        .collection('ExerciseData')
        .doc(docid[index])
        .delete();
    getExerciseData();
  }

  updateData(Map<String, dynamic>? data, int index) async {
    if (data != null) {
      await FirebaseFirestore.instance
          .collection('ExerciseData')
          .doc(docid[index])
          .update(data);
    } else {}
  }

  void updateRows() async {
    rows.assignAll(searchData.isEmpty
        ? exercideData.map((data) {
            return PlutoRow(cells: {
              'nameExercise': PlutoCell(value: data.nameExercise),
              'benefitsExercise': PlutoCell(value: data.benefitsExercise),
              'setORtimeExercise': PlutoCell(value: data.setORtimeExercise),
              'calExercise': PlutoCell(value: data.calExercise),
              'detailExercise': PlutoCell(value: data.detailExercise),
              'deleteIcon': PlutoCell(value: "ลบ")
            });
          }).toList()
        : searchData.map((data) {
            return PlutoRow(cells: {
              'nameExercise': PlutoCell(value: data.nameExercise),
              'benefitsExercise': PlutoCell(value: data.benefitsExercise),
              'setORtimeExercise': PlutoCell(value: data.setORtimeExercise),
              'calExercise': PlutoCell(value: data.calExercise),
              'detailExercise': PlutoCell(value: data.detailExercise),
            });
          }).toList());
    update();
  }

  void search(String query) {
    searchData.clear();
    for (var data in exercideData) {
      if (data.nameExercise!.toLowerCase().contains(query.toLowerCase()) ||
          data.benefitsExercise!.toLowerCase().contains(query.toLowerCase())) {
        searchData.add(data);
        updateRows();
      }
    }
  }

  Future<void> getExerciseData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("ExerciseData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for (var doc in docs) {
      var id = doc.id;
      docid.add(id);
    }
    exercideData.assignAll(docs.map((data) {
      return ExerciseModel(
        nameExercise: data["nameExercise"],
        calExercise: data["calExercise"],
        detailExercise: data["detailExercise"],
        benefitsExercise: data["benefitsExercise"],
        setORtimeExercise: data["setORtimeExercise"],
        imgExercise: data["imgExercise"],
        vdoExercise: data["vdoExercise"],
      );
    }).toList());
    updateRows();
  }

  Future<void> uploadImage() async {
    Get.dialog(WidgetAll.loading());
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final fileBytes = result.files.single.bytes!;
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        await storage.ref('images/$imageName.jpg').putData(fileBytes);
        String imageUrl =
            await storage.ref('images/$imageName.jpg').getDownloadURL();
        imagesName.value = "$imageName.jpg";
        imgUrl = imageUrl;
        update();
        Get.isDialogOpen! ? Get.back() : null;
        Get.dialog(WidgetAll.dialog(
            FontAwesomeIcons.check, "Upload Image succeed", AppColor.green));
      } catch (e) {
        Get.isDialogOpen! ? Get.back() : null;
        Get.dialog(WidgetAll.dialog(FontAwesomeIcons.xmark, "$e", Colors.red));
      }
    }
  }

  Future<void> uploadVideo() async {
    Get.dialog(WidgetAll.loading());
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      final fileBytes = result.files.single.bytes!;
      String vdoname = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        await storage
            .ref('Video/$vdoname.${result.files.single.extension}')
            .putData(fileBytes);
        String vdoURL = await storage
            .ref('Video/$vdoname.${result.files.single.extension}')
            .getDownloadURL();
        videoName.value = "$vdoname.${result.files.single.extension}";
        vdoUrl = vdoURL;
        update();
        Get.isDialogOpen! ? Get.back() : null;
        Get.dialog(WidgetAll.dialog(
            FontAwesomeIcons.check, "Upload Video succeed", AppColor.green));
      } catch (e) {
        Get.isDialogOpen! ? Get.back() : null;
        Get.dialog(WidgetAll.dialog(FontAwesomeIcons.xmark, "$e", Colors.red));
      }
    }
  }

  addExercise() async {
    Get.dialog(WidgetAll.loading());
    if (namecontroller.text.isNotEmpty &&
        detailcontroller.text.isNotEmpty &&
        caloriecontroller.text.isNotEmpty &&
        benefitcontroller.text.isNotEmpty &&
        setortimecontroller.text.isNotEmpty &&
        imgUrl!.isNotEmpty &&
        vdoUrl!.isNotEmpty) {
      await firestore.collection("ExerciseData").doc().set({
        'nameExercise': namecontroller.text,
        'detailExercise': detailcontroller.text,
        'calExercise': caloriecontroller.text,
        'benefitsExercise': benefitcontroller.text,
        'setORtimeExercise': setortimecontroller.text,
        'imgExercise': imgUrl,
        'vdoExercise': vdoUrl
      });
      namecontroller.clear();
      detailcontroller.clear();
      caloriecontroller.clear();
      benefitcontroller.clear();
      setortimecontroller.clear();
      imagesName.value = "Upload Images";
      videoName.value = "Upload Video";
      await getExerciseData();
      Get.isDialogOpen! ? Get.back() : null;
      Get.dialog(WidgetAll.dialog(
          FontAwesomeIcons.check, "Add Exercise Succeed", AppColor.green));
    } else {
      Get.isDialogOpen! ? Get.back() : null;
      Get.dialog(
          WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
              "Data Not Empty", AppColor.orange),
          barrierDismissible: false);
    }
  }
}
