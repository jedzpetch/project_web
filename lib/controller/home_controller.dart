import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_web/controller/login_controller.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/view/login_page.dart';

class HomeController extends GetxController with StateMixin {
  final auth = FirebaseAuth.instance;
  var foodData = [].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final logincontroller = Get.put(LoginController());

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getFoodData();
    update();
    change(null, status: RxStatus.success());
    super.onInit();
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

  signout() async {
    await auth.signOut();
    update();
    Get.to(() => LoginPage());
  }
}
