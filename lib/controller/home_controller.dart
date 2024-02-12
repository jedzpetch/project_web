import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_web/controller/exercise_controller.dart';
import 'package:project_web/controller/login_controller.dart';
import 'package:project_web/model/exercise_mobel.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/view/login_page.dart';

class HomeController extends GetxController with StateMixin {
  final auth = FirebaseAuth.instance;
  var foodData = [].obs;
  var exerciseData = [].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final logincontroller = Get.put(LoginController());
  final exerciseController = Get.put(ExerciseController());

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    input();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  input() async {
    await getFoodData();
    await getExerciseData();
    update();
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

  Future<void> getExerciseData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("ExerciseData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    exerciseData.assignAll(docs.map((data) {
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
  }

  signout() async {
    await auth.signOut();
    update();
    Get.to(() => LoginPage());
  }
}
