import 'package:bustracker/loginpage.dart';
import 'package:bustracker/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //user will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _intialScreen);
  }

  _intialScreen(User? user) {
    if (user != null) {
      print("login page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => SignUpPage()); //CHANGE.......CHANGE....
    }
  }

  Future<void> register(String userid, password) async {
    try {
      UserCredential? userCred = await auth.createUserWithEmailAndPassword(
          email: userid, password: password);
      if (userCred != null) {
        Get.snackbar("Success", "User registration was successful",
            backgroundColor: Colors.greenAccent,
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "Successful",
              style: TextStyle(color: Colors.white),
            ),
            messageText: Text("User registration was successful",
                style: TextStyle(color: Colors.white)));
      }
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText:
              Text(e.toString(), style: TextStyle(color: Colors.white)));
    }
  }

  Future<UserCredential?> login(String userid, password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: userid, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText:
              Text(e.toString(), style: TextStyle(color: Colors.white)));
    }
  }
}
