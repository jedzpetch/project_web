import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(
                  255,
                  160,
                  232,
                  251,
                ),
                Colors.white
              ]),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Calorie Calculator App",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 75),
                      child: Text(
                        "USERNAME",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 500),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.account_circle,
                              color: Colors.blue, size: 45),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
