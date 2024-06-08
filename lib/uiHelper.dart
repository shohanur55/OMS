import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class UiHelper {


  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
        height: 50,
        width: 250,
        child: ElevatedButton(
          onPressed: () {
            voidCallback();
            },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent),
          child:
          Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
        ));
  }

  static CustomAlertDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text,style: Theme.of(context)
                .textTheme
            .titleSmall
                ?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .primary,
                fontWeight:
                FontWeight.normal)),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text("OK")),
            ],
          );
        }

    );
  }
  static logoutdialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text(text,style: Theme.of(context)
                .textTheme
            .titleSmall
                ?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .primary,
                fontWeight:
                FontWeight.normal)),
            actions: [
              TextButton(onPressed: ()async {
                await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
                    context,
                Get.offAll(()=>SplashScreen()) as Route<Object?>,
                ));

              }, child: const Text("LogOut")),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text("Cancel")),
            ],
          );
        }

    );
  }
}