import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaru/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginScreen(),
    );
  }
}
