import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_web/model/food_model.dart';
import 'package:project_web/view/login_page.dart';

class HomeController extends GetxController with StateMixin {
  final auth = FirebaseAuth.instance;
  List foodData = [].obs;
  // String foodImage =
  //     "https://i.pinimg.com/564x/34/f4/8f/34f48f5c56c938642b80b0555e5adf82.jpg";
  // String exerciseImage =
  //     "https://i.pinimg.com/564x/f3/73/f8/f373f80e574bd4eba0123caefe647ce0.jpg";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    // getfoodData();
    change(null, status: RxStatus.success());
    super.onInit();
    update();
  }

  getfoodData() async {
    await firestore.collection("FoodData").doc().get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      if (value.exists) {
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

  signout() async {
    await auth.signOut();
    Get.to(() => LoginPage());
  }
}
