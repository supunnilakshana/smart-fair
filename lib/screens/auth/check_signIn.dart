import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:nearvegi/main.dart';
import 'package:nearvegi/screens/auth/load_userdata.dart';
import 'package:nearvegi/screens/auth/sign_in.dart';
import 'package:nearvegi/test/test1.dart';

class CheckSignIn extends StatelessWidget {
  const CheckSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const LoadUserData();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Somthing wrong!!"),
          );
        } else {
          return const SignIn();
        }
      },
    ));
  }
}
