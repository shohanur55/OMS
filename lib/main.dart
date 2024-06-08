import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/dashboard_screen.dart';
import 'package:firebase_series/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'components.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: baseScreenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: appName,
        initialBinding: InitialBinding(),
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        home: DashBoardScreen(),
      ),
      child: DashBoardScreen(),
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
  //  Get.put(DataController());
  }
}