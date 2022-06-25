import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSuccess extends StatelessWidget {
  late User? user;
  String? _userEmail = "";

  LoginSuccess({Key? key, required UserCredential userCredential})
      : super(key: key) {
    user = userCredential.user;
    _userEmail = user?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Hi $_userEmail",
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          )),
    ));
  }
}
