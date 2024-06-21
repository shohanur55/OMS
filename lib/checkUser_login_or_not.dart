

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/splash_screen.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';

class CheckUser_login_or_not extends StatefulWidget {
  const CheckUser_login_or_not({super.key});

  @override
  State<CheckUser_login_or_not> createState() => _CheckUser_login_or_notState();
}

class _CheckUser_login_or_notState extends State<CheckUser_login_or_not> {

   checkuserLoginOrNot() {
    final user=FirebaseAuth.instance.currentUser;
    if(user==null){
      return SplashScreen();
    }else{
      return DashBoardScreen();
    }
   }

  @override
  Widget build(BuildContext context) {
    return checkuserLoginOrNot();
  }


}
