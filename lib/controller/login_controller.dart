import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_web/model/user_model.dart';
import 'package:project_web/view/home_page.dart';

class LoginController extends GetxController {
  RxList<UserModel> userData = <UserModel>[].obs;
  RxBool obscure = true.obs;
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  showPassword() {
    obscure.value = !obscure.value;
    update();
  }

  login() async {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      await auth.signInWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());
      DocumentSnapshot userExists = await firestore
          .collection('UserData')
          .doc(auth.currentUser!.uid)
          .get();
      if (userExists.exists) {
        Map<String, dynamic> data = userExists.data() as Map<String, dynamic>;
        userData.add(UserModel(
            userID: data['userID'],
            userEmail: data["userEmail"],
            userName: data["userName"],
            userBirthDay: data["userBirthDay"],
            userGender: data["userGender"],
            userImageURL: data["userImageURL"],
            userType: data["userType"],
            userHigh: data["userHigh"],
            userWeight: data["userWeight"]));
        userData.refresh();
      }
      if (userData.isNotEmpty) {
        bool chackType = userData.elementAt(0).userType!.contains("y");
        if (chackType == true) {
          Get.to(() => const HomePage());
        }
      }
    }
  }
}
