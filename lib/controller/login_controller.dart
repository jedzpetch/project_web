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
  static RxList<UserModel> userData = <UserModel>[].obs;
  RxBool obscure = true.obs;
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  showPassword() {
    obscure.value = !obscure.value;
  }

  login() async {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      Get.dialog(WidgetAll.loading());
      try {
        await auth.signInWithEmailAndPassword(
            email: emailTextController.text,
            password: passwordTextController.text);
        DocumentSnapshot userExists = await firestore
            .collection('UserData')
            .doc(auth.currentUser!.uid)
            .get();
        if (userExists.exists) {
          Map<String, dynamic> data = userExists.data() as Map<String, dynamic>;
          if (data["userType"] == 'y') {
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

            Get.off(() => HomePage());
          } else {
            auth.signOut();
            Get.dialog(WidgetAll.dialog(
              FontAwesomeIcons.x,
              "Limit Sign In to administrators only.",
              Colors.red,
            ));
            await Future.delayed(const Duration(milliseconds: 2000));
            if (Get.isDialogOpen!) {
              Get.back();
            }
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
    emailTextController.clear();
    passwordTextController.clear();
  }
}
