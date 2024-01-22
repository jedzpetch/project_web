import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:project_web/controller/login_controller.dart';
import 'package:project_web/view/home_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:project_web/firebase_options.dart';
import 'package:project_web/view/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KitCal',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              primaryColor: Colors.black),
          home: controller.userData.isEmpty ? HomePage() : LoginPage());
    });
  }
}
