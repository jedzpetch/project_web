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
import 'package:project_web/model/exercise_mobel.dart';
import 'package:project_web/widget.dart';

class ExerciseController extends GetxController with StateMixin {
  var exercideData = <ExerciseMobel>[].obs;
  RxList<ExerciseMobel> searchData = <ExerciseMobel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final namecontroller = TextEditingController();
  final detailcontroller = TextEditingController();
  final caloriecontroller = TextEditingController();
  final benefitcontroller = TextEditingController();
  final setortimecontroller = TextEditingController();
  RxString imagesName = RxString("Upload Images");
  RxString videoName = RxString("Upload Video");
  String? imgUrl;
  String? vdoUrl;
  final List<PlutoRow> rows = <PlutoRow>[].obs;
  final List<PlutoColumn> columns = [
    PlutoColumn(
        title: "Name",
        field: "name",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Benefits",
        field: "benefits",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "SetorTime",
        field: "setortime",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Calorie",
        field: "calorie",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
        title: "Detail",
        field: "detail",
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center),
  ].obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getExerciseData();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void updateRows() async {
    rows.assignAll(searchData.isEmpty
        ? exercideData.map((data) {
            return PlutoRow(cells: {
              'name': PlutoCell(value: data.nameExercise),
              'benefits': PlutoCell(value: data.benefitsExercise),
              'setortime': PlutoCell(value: data.setORtimeExercise),
              'calorie': PlutoCell(value: data.calExercise),
              'detail': PlutoCell(value: data.detailExercise),
            });
          }).toList()
        : searchData.map((data) {
            return PlutoRow(cells: {
              'name': PlutoCell(value: data.nameExercise),
              'benefits': PlutoCell(value: data.benefitsExercise),
              'setortime': PlutoCell(value: data.setORtimeExercise),
              'calorie': PlutoCell(value: data.calExercise),
              'detail': PlutoCell(value: data.detailExercise),
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
    exercideData.assignAll(docs.map((data) {
      return ExerciseMobel(
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
