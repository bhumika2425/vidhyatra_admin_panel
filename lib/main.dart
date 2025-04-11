// main.dart
import 'package:admin_panel/controllers/login_controller.dart';
import 'package:admin_panel/screens/dashboard.dart';
import 'package:admin_panel/screens/landing_page.dart';
import 'package:admin_panel/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() {
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vidhyatra Admin',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      getPages: [

        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/dashboard', page: () => AdminDashboard()),
      ],
    );
  }
}