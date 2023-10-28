import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_web/view/login_page.dart';

void main() => runApp(const GetMaterialApp(
    title: 'Project Web',
    debugShowCheckedModeBanner: false,
    home: LoginPage()));

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Project Web',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//     );
//   }
// }
