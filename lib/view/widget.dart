import 'package:flutter/material.dart';
import 'package:project_web/Constant/colors.dart';

class Textformfield {
  static Widget textformfield(String title, IconData icon, Function function) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      const SizedBox(height: 5),
      Row(children: [
        SizedBox(
            width: 350,
            child: TextFormField(
                decoration: InputDecoration(
              filled: true,
              icon: Icon(icon, color: Colors.blue, size: 45),
              labelStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.indigo, width: 2)),
            )))
      ])
    ]);
  }

  static Widget textformfieldPassWord(
      String title, IconData icon, bool obscure, Function function) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      const SizedBox(height: 5),
      Row(children: [
        SizedBox(
            width: 350,
            child: TextFormField(
                obscureText: obscure,
                decoration: InputDecoration(
                  filled: true,
                  icon: Icon(icon,
                      color: Colors.amber,
                      size: 45,
                      shadows: const [
                        Shadow(blurRadius: 2, color: Colors.black)
                      ]),
                  labelStyle: const TextStyle(color: Colors.black),
                  suffixIcon: IconButton(
                      onPressed: () => function(),
                      icon: obscure
                          ? const Icon(Icons.visibility_off,
                              color: Colors.black)
                          : const Icon(Icons.visibility,
                              color: AppColor.textbase)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      )),
                )))
      ])
    ]);
  }
}

class Button {
  static buttonSave(String label, Icon icon, Function save) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Container(
        width: 250,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment(-0.95, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [AppColor.background, Color(0xff64b6ff)],
              stops: [0.0, 1.0],
            ),
            border: Border.all(width: 2)),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {},
          icon: icon,
          label: Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
