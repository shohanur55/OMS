


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/app_screens/addEmployee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addUser() async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc('user_info');

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          // If the document does not exist, create it with an initial list
          transaction.set(docRef, {
            'user_list': [
              {'email': email, 'password': password}
            ]
          });
        } else {
          // If the document exists, update the list
          List<dynamic> userList = snapshot['user_list'] ?? [];
          userList.add({'email': email, 'password': password});

          transaction.update(docRef, {'user_list': userList});
        }
      });

      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  if ((email == "") || (password == "")) {
    UiHelper.CustomAlertDialog(context, "Please fill up all requirement");
  } else {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          ;

     addUser();
    }

    on FirebaseAuthException catch (ex) {
      return UiHelper.CustomAlertDialog(context, ex.code.toString());
    }
  }
}

}