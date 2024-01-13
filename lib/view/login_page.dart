import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_web/Constant/colors.dart';
import 'package:project_web/controller/login_controller.dart';
import 'package:project_web/view/home_page.dart';
import 'package:project_web/view/widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  final loginController = Get.put(LoginController());
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(color: AppColor.blue),
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Center(
                              child: Text("Calorie Calculator App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      color: AppColor.textbase))),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(children: [
                                  Textformfield.textformfield(
                                      "USERNAME",
                                      Icons.account_circle,
                                      loginController.emailTextController),
                                  const SizedBox(height: 20),
                                  GetX<LoginController>(
                                      init: LoginController(),
                                      initState: (_) {},
                                      builder: (_) {
                                        return Textformfield
                                            .textformfieldPassWord(
                                                "PASSWORD",
                                                FontAwesomeIcons.key,
                                                _.obscure.value,
                                                () => _.showPassword(),
                                                loginController
                                                    .passwordTextController);
                                      }),
                                  const SizedBox(height: 20),
                                  Center(
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Button.buttonSave(
                                            "Login",
                                            Icon(Icons.login,
                                                color: Colors.yellow.shade300,
                                                shadows: const [
                                                  Shadow(
                                                      blurRadius: 2,
                                                      color: Colors.black)
                                                ]),
                                            () =>
                                                Get.to(() => const HomePage()),
                                          )))
                                ]),
                                const Spacer(),
                                const SizedBox(height: 20),
                                Column(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.background,
                                          border: Border.all(width: 2),
                                          borderRadius:
                                              BorderRadius.circular(500)),
                                      child: const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Icon(
                                              FontAwesomeIcons.personRunning,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 2,
                                                    color: Colors.black)
                                              ],
                                              size: 250,
                                              color: Colors.yellowAccent))),
                                  const SizedBox(height: 50),
                                  const Text("Login",
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                blurRadius: 2,
                                                color: Colors.black)
                                          ],
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50)),
                                  const SizedBox(height: 10),
                                  const Text("For Admin",
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                blurRadius: 2,
                                                color: Colors.black)
                                          ],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50))
                                ])
                              ])
                        ])))));
  }
}
