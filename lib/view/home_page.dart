import 'package:flutter/material.dart';
import 'package:project_web/Constant/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Text(
      "Hello",
      style: TextStyle(color: AppColor.black),
    )));
  }
}
