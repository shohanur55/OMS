
import 'package:firebase_series/departmentLogin.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 // final DataController _controller = Get.find();
  bool isShowSplashScreen = false;
  bool isInitApp = false;

  @override
  void initState() {
    super.initState();
    showSplashScreen();
    initApp();
  }

  //! ---------------------------------------------------------------------------------------------- Showing splash screen
  Future<void> showSplashScreen() async {
    await Future.delayed(const Duration(seconds: defaultSplashScreenShow));
    isShowSplashScreen = true;
    showMainApp();
  }

  //! ---------------------------------------------------------------------------------------------- Init app
  Future<void> initApp() async {
    //await _controller.initApp();
    isInitApp = true;
    //devPrint("App Initialized");
    showMainApp();
  }

  //! ---------------------------------------------------------------------------------------------- Entering main app
  void showMainApp() {
    if (isShowSplashScreen && isInitApp) {
    //  devPrint("Showing main app");

      // if (_controller.isLogin()) {
      //   Get.offAll(() => DashBoardScreen());
      // } else {
         Get.offAll(() => Departmentlogin());
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(child: Center(child: Text("Office Management System",style: TextStyle(fontSize: 27,color: Colors.white),))),
    );
  }
}
