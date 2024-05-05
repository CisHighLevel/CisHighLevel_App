import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_2/login.dart';
import 'package:prueba_flutter_2/widget/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PROYECTO EA',
      theme: ThemeData(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
