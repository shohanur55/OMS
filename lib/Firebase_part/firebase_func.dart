


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../dashboard_screen.dart';
import '../main.dart';
import '../uiHelper.dart';

class Firebase_func{
static logIn(BuildContext? context,String email, String password) async {
  if ((email == "") || (password == "")) {
    UiHelper.CustomAlertDialog(context!, "Please fill up all requirement");
  } else {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>  Get.offAll(DashBoardScreen()));


    }

    on FirebaseAuthException catch (ex) {
      return UiHelper.CustomAlertDialog(context!, ex.code.toString());
    }
  }
}
static signUp(BuildContext context,String email, String password) async {
  if ((email == "") || (password == "")) {
    UiHelper.CustomAlertDialog(context, "Please fill up all requirement");
  } else {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          ;
    }

    on FirebaseAuthException catch (ex) {
      return UiHelper.CustomAlertDialog(context, ex.code.toString());
    }
  }
}

}