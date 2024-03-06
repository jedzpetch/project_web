import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_web/controller/exercise_controller.dart';
import 'package:project_web/controller/login_controller.dart';
import 'package:project_web/model/exercise_model.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/model/goal_model.dart';
import 'package:project_web/model/user_model.dart';
import 'package:project_web/view/login_page.dart';

class HomeController extends GetxController with StateMixin {
  final auth = FirebaseAuth.instance;
  RxList<FoodModel> foodData = <FoodModel>[].obs;
  var exerciseData = [].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final logincontroller = Get.put(LoginController());
  final exerciseController = Get.put(ExerciseController());
  RxList<UserModel> userData = <UserModel>[].obs;
  RxList<GoalModel> goalData = <GoalModel>[].obs;

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
    await getUserData();
    await getgoalData();
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

  Future<void> getUserData() async {
    QuerySnapshot querySnapshot = await firestore.collection("UserData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    userData.assignAll(docs.map((data) {
      return UserModel(
          userID: data["userID"],
          userEmail: data["userEmail"],
          userName: data["userName"],
          userType: data["userType"]);
    }).toList());
  }

  Future<void> getgoalData() async {
    QuerySnapshot querySnapshot = await firestore.collection("goalData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    goalData.assignAll(docs.map((data) {
      return GoalModel(
          goalStartDate: data["goalStartDate"],
          goalEndDate: data["goalEndDate"]);
    }).toList());
  }

  Future<void> getExerciseData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("ExerciseData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    exerciseData.assignAll(docs.map((data) {
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
  }

  signout() async {
    await auth.signOut();
    update();
    Get.off(() => LoginPage());
  }

  checkUserType(int index) {
    if (userData.isNotEmpty) {
      switch (userData[index].userType) {
        case "y":
          return "ผู้ดูแลระบบ";
        case "n":
          return "ผู้ใช้งาน";
      }
    }
  }
}
