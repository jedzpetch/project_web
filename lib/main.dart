import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:project_web/view/exercise/editexercise_page.dart';
import 'package:project_web/view/exercise/exercise_page.dart';
import 'package:project_web/view/food/editfood_page.dart';
import 'package:project_web/view/food/food_page.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          initialRoute: "/",
          getPages: [
            GetPage(name: "/login", page: () => LoginPage()),
            GetPage(name: "/HomePage", page: () => HomePage()),
            GetPage(name: "/FoodPage", page: () => const FoodPage()),
            GetPage(name: "/EditFoodPage", page: () => const EditFoodPage()),
            GetPage(name: "/ExercisePage", page: () => ExercisePage()),
            GetPage(name: "/EditExercisePage", page: () => EditExercisePage()),
          ],
          home: LoginPage());
    });
  }
}
