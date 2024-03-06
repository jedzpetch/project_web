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
        backgroundColor: AppColor.orange.withAlpha(400),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Center(
                  child: Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 25.w,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Image.asset(
                                                    "lib/asset/image/iconApp.jpg",
                                                    scale: 1.5)),
                                            SizedBox(height: 5.h)
                                          ])),
                                  Container(
                                      height: 70.h,
                                      width: 45.w,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "เข้าสู่ระบบสำหรับผู้ดูแลระบบ",
                                                style: Font.white20B),
                                            Textformfields.fieldBlankWithIcon(
                                                "อีเมล",
                                                FontAwesomeIcons.user,
                                                controller.emailTextController,
                                                AppColor.orange),
                                            SizedBox(height: 2.h),
                                            Obx(() =>
                                                Textformfields.fieldPassWord(
                                                    "รหัสผ่าน",
                                                    FontAwesomeIcons.lock,
                                                    controller.obscure.value,
                                                    () => controller
                                                        .showPassword(),
                                                    controller
                                                        .passwordTextController,
                                                    true)),
                                            SizedBox(height: 5.h),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColor.orange),
                                                onPressed: () async {
                                                  await controller.login();
                                                },
                                                child: const Text("เข้าสู่ระบบ",
                                                    style: Font.black18B))
                                          ]))
                                ])
                          ])))
            ])));
  }
}
