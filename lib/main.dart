// ignore_for_file: unnecessary_import, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/controller/auth_controller.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TesW());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.authStatus,
        builder:  (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
              // initialRoute: Routes.LOGIN,
              getPages: AppPages.routes,
            );
          } else {
            return GetMaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}

class TesW extends StatelessWidget {
  final auth = Get.put(AuthController());
  RxString role = ''.obs;
  void checkData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedRole = prefs.getString('role');
    if (savedRole != null) {
      role.value = savedRole;
    }
    print(role.value);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.authStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print("tesssssssssssss");
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
              // initialRoute: Routes.REGISTER,
              getPages: AppPages.routes,
            );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
