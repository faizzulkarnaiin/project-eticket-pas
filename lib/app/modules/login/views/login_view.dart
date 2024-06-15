// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, sort_child_properties_last, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/controller/auth_controller.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Color PrimaryText = Color(0xff161A30);
    Color PrimaryBg = Color(0xffF0ECE5);
    Color AccentOne = Color(0xff31304D);
    Color AccentTwo = Color(0xffB6BBC4);
    final srt = Get.put(AuthController());
    return Scaffold(
      backgroundColor: PrimaryBg,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/city_bus-bro.webp",
            scale: 7,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Text("Login",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: PrimaryText)),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24),
            height: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: TextField(
              controller: srt.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w500, color: AccentOne),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AccentOne, strokeAlign: 12))),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24),
            height: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: TextField(
              obscureText: true,
              controller: srt.password,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "Password",
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w500, color: AccentOne),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AccentOne, strokeAlign: 12))),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: () {
                srt.login(srt.emailAddress.text, srt.password.text);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AccentTwo),
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: AccentOne),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AccentOne),
                          children: <TextSpan>[
                        TextSpan(
                            text: "Register",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                color: AccentOne))
                      ])),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.RESET_PASSWORD),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AccentOne),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 1,
                  decoration: BoxDecoration(color: AccentOne),
                ),
                Text("Or Login With"),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 1,
                  decoration: BoxDecoration(color: AccentOne),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            // alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width * 0.25,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: AccentOne),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => srt.signInWithGoogle(),
                  child: Image.asset("assets/logo_google.webp"),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Google",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: AccentOne),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
