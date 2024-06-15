// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names, use_super_parameters, must_be_immutable, prefer_final_fields, unnecessary_import, unused_import, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:project_pas_bus_eticket/app/controller/auth_controller.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color PrimaryText = Color(0xff161A30);
    Color PrimaryBg = Color(0xffF0ECE5);
    Color AccentOne = Color(0xff31304D);
    Color AccentTwo = Color(0xffB6BBC4);
    final auth = Get.put(AuthController());
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
            child: Text("Register",
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
              controller: auth.nama,
              decoration: InputDecoration(
                  labelText: "Username",
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
              controller: auth.emailAddress,
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
              controller: auth.password,
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
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 24),
              height: 55,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Obx(
                () => DropdownButtonFormField(
                  value: auth.selectedRole.value,
                  onChanged: (value) {
                    auth.selectedRole(value);
                    print(auth.selectedRole.value);
                  },
                  items: <String>['user', 'admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: () {
                auth.register(auth.emailAddress.text, auth.password.text,
                    auth.selectedRole.value);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: Text(
                  "Register",
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
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.LOGIN),
              child: RichText(
                  text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AccentOne),
                      children: <TextSpan>[
                    TextSpan(
                        text: "Login",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            color: AccentOne))
                  ])),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.335,
                  height: 1,
                  decoration: BoxDecoration(color: AccentOne),
                ),
                Text("Or Register With"),
                Container(
                  width: MediaQuery.of(context).size.width * 0.335,
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
                Image.asset("assets/logo_google.webp"),
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
