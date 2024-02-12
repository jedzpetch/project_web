import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/Constant/font.dart';
import 'package:project_web/controller/login_controller.dart';
import 'package:project_web/widget.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.platinum,
        body: Column(children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 100.h,
                    width: 60.w,
                    decoration: const BoxDecoration(color: AppColor.platinum),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dashboard KitCal", style: Font.black20B),
                                Text("For Admin", style: Font.black18B)
                              ]),
                          Icon(Icons.settings,
                              size: 25.w, color: AppColor.orange)
                        ])),
                Container(
                    height: 100.h,
                    width: 40.w,
                    decoration: const BoxDecoration(color: AppColor.black),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("lib/asset/image/iconApp.jpg", scale: 2),
                          Textformfields.fieldBlank(
                              "Email",
                              FontAwesomeIcons.user,
                              controller.emailTextController,
                              AppColor.orange),
                          SizedBox(height: 2.h),
                          GetX<LoginController>(
                              init: LoginController(),
                              initState: (_) {},
                              builder: (_) {
                                return Textformfields.fieldPassWord(
                                    "Password",
                                    FontAwesomeIcons.lock,
                                    _.obscure.value,
                                    () => _.showPassword(),
                                    controller.passwordTextController,
                                    true);
                              }),
                          SizedBox(height: 2.h),
                          Button.buttonSave("login", () => controller.login())
                        ]))
              ])
        ]));
  }
}
