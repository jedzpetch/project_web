import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/model/user_model.dart';
import 'package:project_web/view/home_page.dart';
import 'package:project_web/widget.dart';

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
      Get.dialog(WidgetAll.loading());
      try {
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
        Future.delayed(const Duration(seconds: 5));
        if (userData.isNotEmpty) {
          bool chackType = userData.elementAt(0).userType!.contains("y");
          if (chackType == true) {
            if (Get.isDialogOpen!) {
              Get.back();
              Get.to(() => HomePage());
            }
          } else {
            await auth.signOut();
            Get.dialog(WidgetAll.dialog(FontAwesomeIcons.x,
                "Limit Sign In to administrators only.", Colors.red));
          }
        }
      } on FirebaseAuthException catch (error) {
        Get.isDialogOpen! ? Get.back() : null;
        switch (error.code) {
          case "invalid-email":
            Get.dialog(
                WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
                    "invalid email", AppColor.orange),
                barrierDismissible: false);
            break;
          case "INVALID_LOGIN_CREDENTIALS":
            Get.dialog(
                WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
                    "please check your email and password", AppColor.orange),
                barrierDismissible: false);
            break;
          default:
            Get.dialog(
                WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
                    "can't signin", AppColor.orange),
                barrierDismissible: false);
        }
      }
    } else {
      Get.dialog(
          WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
              "Please Enter Email&Password", AppColor.orange),
          barrierDismissible: false);
    }
  }
}
