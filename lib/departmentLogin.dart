import 'package:firebase_series/login_screen.dart';
import 'package:firebase_series/widget/base_components/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components.dart';

class Departmentlogin extends StatefulWidget {
  const Departmentlogin({super.key});

  @override
  State<Departmentlogin> createState() => _DepartmentloginState();
}

class _DepartmentloginState extends State<Departmentlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(child: Text("Office Management System",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 22,),)),
      SizedBox(height: defaultPadding),
      Text("Please Login With perspective Department",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22,),),
      SizedBox(height: defaultPadding),
      //Image.asset("lib/assets/logo/logo.png", height: defaultPadding),
      SizedBox(height: defaultPadding),
      CustomElevatedButton(
          expanded: true,
          border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: Theme.of(context).cardColor),
          child: const Text("Admin  Login"),

          onTap:() {
            Get.to(()=>LoginScreen(dept: "Admin",));
          }),  SizedBox(height: defaultPadding), CustomElevatedButton(
          expanded: true,
          border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: Theme.of(context).cardColor),
          child: const Text("HR Department Login"),

          onTap:() {
            Get.to(()=>LoginScreen(dept:"HR Department"));
          }), SizedBox(height: defaultPadding), CustomElevatedButton(
          expanded: true,
          border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: Theme.of(context).cardColor),
          child: const Text("Accounts Department Login"),

          onTap:() {
            Get.to(()=>LoginScreen(dept: "Accounts Department",));
          }), SizedBox(height: defaultPadding), CustomElevatedButton(
          expanded: true,
          border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: Theme.of(context).cardColor),
          child: const Text("Marketing Department Login"),

          onTap:() {
            Get.to(()=>LoginScreen(dept: "Marketing Department",));
          }),
      SizedBox(height: defaultPadding), CustomElevatedButton(
          expanded: true,
          border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: Theme.of(context).cardColor),
          child: const Text("Software Department Login"),

          onTap:() {
            Get.to(()=>LoginScreen(dept: "Software Department",));
          }),
    ],
  ),
),
    );
  }
}
