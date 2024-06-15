// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, unnecessary_import, unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class AuthController extends GetxController {
//   Stream authStatus = FirebaseAuth.instance.authStateChanges();

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void increment() => count.value++;
//   login(String emailAddress, String password) async {
//     try {
//       Get.defaultDialog(content: CircularProgressIndicator(), title: 'Loading');
//       final credential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: emailAddress, password: password);
//       Get.offAllNamed(Routes.HOME);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         // Get.defaultDialog(
//         //     content: Icon(
//         //       Icons.warning,
//         //       color: Colors.yellow,
//         //     ),
//         //     title: 'No user found for that email.');
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         // Get.defaultDialog(
//         //     content: Icon(
//         //       Icons.warning,
//         //       color: Colors.yellow,
//         //     ),
//         //     title: 'Wrong password provided for that user.');
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   logout() async {
//     await FirebaseAuth.instance.signOut();
//     Get.offAllNamed(Routes.LOGIN);
//   }

//   register(String emailAddress, String password) async {
//     try {
//       Get.defaultDialog(content: CircularProgressIndicator(), title: 'Loading');
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailAddress,
//         password: password,
//       );
//       Get.offAllNamed(Routes.HOME);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         Get.defaultDialog(
//             content: Icon(
//               Icons.warning,
//               color: Colors.yellow,
//             ),
//             title: 'Wrong password provided for that user.');
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
class AuthController extends GetxController {
  Stream authStatus = FirebaseAuth.instance.authStateChanges();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoggedIn = false.obs;
  var userRole = "".obs;
  var selectedRole = 'user'.obs;
  void changeSelectedRole(String newRole) {
    selectedRole.value = newRole;
  }

  register(String email, String password, String role) async {
    try {
      Get.defaultDialog(content: CircularProgressIndicator(), title: 'Loading');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,
      });
      login(email, password);
      if (userRole.value == "admin") {
        Get.offAllNamed(Routes.ADMIN);
      } else {
        Get.offAllNamed(Routes.USER);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  login(String email, String password) async {
    try {
      Get.defaultDialog(content: CircularProgressIndicator(), title: 'Loading');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoggedIn.value = true;
      await _getUserRole(userCredential.user!.uid);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('role', userRole.value);
      prefs.setString('userId', userCredential.user!.uid);
      var uidddd = prefs.getString('userId');
      if (uidddd != null) {
        var uidd = uidddd;
        print(uidd);
      }
      print(userCredential.user!.uid);
      if (userRole.value == "admin") {
        Get.offAllNamed(Routes.ADMIN);
      } else {
        Get.offAllNamed(Routes.USER);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void logout() async {
    await auth.signOut();
    isLoggedIn.value = false;
    userRole.value = "";
  }

  Future<void> _getUserRole(String uid) async {
    DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
    userRole.value = doc['role'];
  }

  signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(Routes.USER);
    } catch (e) {
      try {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        Get.offAllNamed(Routes.HOME);
        // Or use signInWithRedirect
        // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
      } catch (e) {
        Get.defaultDialog(
            middleText: 'Gagal Login dengan Google', title: 'Error');
      }
      // Create a new provider
    }
  }

  resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          title: 'Berhasil',
          middleText: 'Email Terkirim !! silahkan cek email anda',
          confirm: ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.LOGIN),
              child: Text('Ok')));
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Mengirim Emal, ');
    }
  }
}
