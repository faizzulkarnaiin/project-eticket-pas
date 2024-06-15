// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/controller/auth_controller.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
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
          Padding(
            padding:
                const EdgeInsets.only(top: 18, right: 24, left: 24, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: PrimaryText,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: PrimaryText),
                ),
                SizedBox(
                  width: 1,
                )
              ],
            ),
          ),
          // Image.asset(
          //   "assets/Forgot password-cuate.png",
          //   scale: 7,
          // ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Forgot Password?",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: PrimaryText),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            textAlign: TextAlign.center,
            "Don't worry! Please enter the email address to\nrecieve password reset instruction.",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: PrimaryText),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextField(
                  controller: srt.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        color: PrimaryText,
                      ),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      label: Text("Email"),
                      labelStyle: TextStyle(
                          color: PrimaryText, fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        srt.resetPassword(srt.emailAddress.text);
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: AccentOne),
                    )),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
